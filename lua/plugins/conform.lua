-- formatter
return {
	"stevearc/conform.nvim",
	opts = {
		format_on_save = function(bufnr)
			if vim.b[bufnr].disable_autoformat then
				return nil
			end
			return {
				timeout_ms = 500,
				lsp_fallback = true,
			}
		end,
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
		vim.keymap.set("n", "<leader>f", conform.format, { desc = "Format file" })
	end,
}
