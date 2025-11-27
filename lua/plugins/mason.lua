return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
	},
	cmd = "Mason",
	event = "VeryLazy",
	config = function()
		require("mason").setup()

		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "clangd", "pyright", "eslint" },
			automatic_installation = true,
		})

		-- It auto-loads the plugins such as clangd
		vim.lsp.enable("clangd")
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("pyright")
		vim.lsp.enable("eslint")

		-- Optional: capabilities for cmp (applied globally via vim.lsp.config if needed)
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
	end,
}
