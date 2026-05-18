return {
	"github/copilot.vim",
	config = function()
		CopilotDisabled = true
		local cp_toggle = function()
			CopilotDisabled = not CopilotDisabled
			if CopilotDisabled then
				vim.cmd("Copilot disable")
			else
				vim.cmd("Copilot enable")
			end
		end
		vim.cmd("Copilot disable")
		vim.keymap.set("n", "<leader>cs", "<cmd>Copilot status<CR>", { desc = "[C]opilot: [S]tatus", noremap = true })
		vim.keymap.set("n", "<leader>ct", cp_toggle, { desc = "[C]opilot: [T]oggle", noremap = true })
	end
}
