-- formatter
return {
	"stevearc/conform.nvim",
	opts = {
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true, -- uses LSP formatter if no external one
		},
		formatters_by_ft = {
			c = { "clang_format" },
			cpp = { "clang_format" },
			lua = { "stylua" },
			python = { "black" },
		},
	},
	config = function(_, opts)
		local conform = require("conform")
		conform.setup(opts)

		-- Format on demand
		vim.keymap.set("n", "<leader>f", conform.format, { desc = "Format file" })
	end,
}
