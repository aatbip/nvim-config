return {
	"nvim-telescope/telescope.nvim",
	tag = "v0.1.9",
	dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" },
	config = function()
		local telescope = require("telescope")
		telescope.setup({})
		-- Custom highlight overrides (updated for dark, subdued colors with good visibility)
		vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = "#3e4452" })
		vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#98c379", bold = true })
		vim.api.nvim_set_hl(0, "TelescopePreviewMatch", { bg = "#3e4452", fg = "#e5c07b", bold = true })
		vim.api.nvim_set_hl(0, "TelescopePreviewLine", { bg = "#3e4452" })
		vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#4b5263" })
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
	end,
}
