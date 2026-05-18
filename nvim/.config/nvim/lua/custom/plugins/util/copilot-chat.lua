return {
	"CopilotC-Nvim/CopilotChat.nvim",
	dependencies = {
		"nvim=lua/plenary.nvim",
	},
	build = "make tiktoken",
	opts = {
		model = 'Claude Sonnet 4.5',
		temperature = 0.5,
		window = {
			layout = 'vertical',
			width = 0.3
		},
		auto_insert_mode = 'true'
	},
}
