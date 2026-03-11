return {
	-- Lua dev support
	{
		'folke/lazydev.nvim',
		ft = 'lua',
		opts = {
			library = {
				{ path = '${3rd}/luv/library', words = { 'vim%.uv' } },
			},
		},
	},

	{
		'neovim/nvim-lspconfig',
		dependencies = {
			-- lsp status
			{ 'j-hui/fidget.nvim', opts = {} },
		},
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()

			vim.diagnostic.config {
				severity_sort = true,
				float = { border = 'rounded', source = 'if_many' },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = vim.g.have_nerd_font and {
					text = {
						[vim.diagnostic.severity.ERROR] = '󰅚 ',
						[vim.diagnostic.severity.WARN] = '󰀪 ',
						[vim.diagnostic.severity.INFO] = '󰋽 ',
						[vim.diagnostic.severity.HINT] = '󰌶 ',
					},
				} or {},
				virtual_text = {
					source = 'if_many',
					spacing = 2,
					format = function(diagnostic)
						return diagnostic.message
					end,
				},
			}

			local common_on_attach = function(client, bufnr)
				local map = function(keys, func, desc, mode)
					mode = mode or 'n'
					vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
				end

				map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
				map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
				map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
				map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
				map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
				map('<leader>fs', require('telescope.builtin').lsp_document_symbols, '[F]ind [S]ymbols')
				map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
				map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
				map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
				map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

				if vim.lsp.inlay_hint and client.supports_method('textDocument/inlayHint') then
					map('<leader>th', function()
						local enabled = vim.lsp.inlay_hint.is_enabled(bufnr)
						vim.lsp.inlay_hint.enable(bufnr, { enabled = not enabled })
					end, '[T]oggle Inlay [H]ints')
				end

				if client.supports_method('textDocument/documentHighlight') then
					local group = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
					vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
						group = group,
						buffer = bufnr,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
						group = group,
						buffer = bufnr,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end

			local on_attach_clangd_default = (vim.lsp.config['clangd'] or {}).on_attach
			local on_attach_clangd = function(client, bufnr)
				local map = function(keys, func, desc, mode)
					mode = mode or 'n'
					vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
				end
				common_on_attach(client, bufnr)
				map('go', '<cmd>LspClangdSwitchSourceHeader<CR>', '[G]oto Header/Source')
			end

			-- Built-in LSP server definitions
			vim.lsp.config('clangd', {
				cmd = { os.getenv('CLANGD_PATH') or 'clangd', '--pretty', '--clang-tidy' },
				init_options = {
					fallbackFlags = { '-std=c++23' },
				},
				filetypes = { "cpp", "c" },
				capabilities = capabilities,
				on_attach = {
					on_attach_clangd_default,
					on_attach_clangd,
				}
			})
			vim.lsp.enable('clangd')

			vim.lsp.config('rust', {
				cmd = { 'rust-analyzer' },
				-- init_options = {
				-- 	fallbackFlags = { '-std=c++17' },
				-- },
				root_markers = { "Cargo.toml", ".git" },
				filetypes = { "rust" },
				capabilities = capabilities,
				on_attach = common_on_attach,
				before_init = function(init_params, config)
					-- See https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26
					if config.settings and config.settings['rust-analyzer'] then
						init_params.initializationOptions = config.settings['rust-analyzer']
					end
				end,
			})
			vim.lsp.enable('rust')

			vim.lsp.config('lua_ls', {
				cmd = { 'lua-language-server' },
				settings = {
					Lua = {
						completion = { callSnippet = 'Replace' },
					},
				},
				filetypes = { "lua" },
				capabilities = capabilities,
				on_attach = on_attach,
				root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
			})
			vim.lsp.enable('lua_ls')
		end,
	},

	-- Formatter
	{
		'stevearc/conform.nvim',
		event = { 'BufWritePre' },
		cmd = { 'ConformInfo' },
		keys = {
			{
				'<leader>mf',
				function()
					require('conform').format { async = true, lsp_format = 'fallback' }
				end,
				mode = '',
				desc = '[F]ormat buffer',
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disabled = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_format = disabled[vim.bo[bufnr].filetype] and 'never' or 'fallback',
				}
			end,
			formatters_by_ft = {
				lua = { 'stylua' },
			},
		},
	},

	-- CMP
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			{
				'L3MON4D3/LuaSnip',
				build = (function()
					if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
						return
					end
					return 'make install_jsregexp'
				end)(),
			},
			'saadparwaiz1/cmp_luasnip',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-nvim-lsp-signature-help',
		},
		config = function()
			local cmp = require 'cmp'
			local luasnip = require 'luasnip'
			luasnip.config.setup {}

			cmp.setup {
				snippet = {
					expand = function(args) luasnip.lsp_expand(args.body) end,
				},
				completion = { completeopt = 'menu,menuone,noinsert' },
				mapping = cmp.mapping.preset.insert {
					['<C-n>'] = cmp.mapping.select_next_item(),
					['<C-p>'] = cmp.mapping.select_prev_item(),
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-y>'] = cmp.mapping.confirm { select = true },
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-l>'] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { 'i', 's' }),
					['<C-h>'] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { 'i', 's' }),
				},
				sources = {
					{ name = 'lazydev',                group_index = 0 },
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
					{ name = 'path' },
					{ name = 'nvim_lsp_signature_help' },
				},
			}
		end,
	},
}
