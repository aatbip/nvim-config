-- plugin for handling multiple tabs
-- ~/.config/nvim/lua/plugins/barbar.lua
return {
	"romgrk/barbar.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "BufReadPre",
	keys = {
		{ "<Leader>bn", "<Cmd>BufferNext<CR>", desc = "Next tab" },
		{ "<Leader>bb", "<Cmd>BufferPrevious<CR>", desc = "Prev tab" },
		{ "<leader>c", "<Cmd>BufferClose<CR>", desc = "Close tab" },
		{ "<leader>bp", "<Cmd>BufferPin<CR>", desc = "Pin tab" },
		{ "<leader>bo", "<Cmd>BufferCloseAllButCurrent<CR>", desc = "Close others" },
	},
	config = function()
		require("barbar").setup({
			animation = false,
			auto_hide = false, -- hides tabline when only one tab
			clickable = true,
			icons = {
				pinned = { button = "Pin", filename = true },
				modified = { button = "●" },
				filetype = {
					enabled = true,
					custom_colors = true,
				},
			},
		})
		vim.api.nvim_set_hl(0, "BufferTabpageFill", { bg = "#1f1f1f" })
		vim.api.nvim_set_hl(0, "BufferCurrent", { bg = "#807e7a", fg = "#b8e3f5", bold = true })
		vim.api.nvim_set_hl(0, "BufferInactive", { bg = "#262625", fg = "#bbc2cf" })
		vim.api.nvim_set_hl(0, "BufferCurrentIcon", { bg = "#1a1a1a" })
		vim.api.nvim_set_hl(0, "BufferCurrentMod", { bg = "#51afae", fg = "#ffffff", bold = true })

		-- Set highlight groups for the filetype icon
		vim.api.nvim_set_hl(0, "BufferCurrentIcon", { fg = "#06bd95", bg = "#e8dfb0" }) -- current buffer
		vim.api.nvim_set_hl(0, "BufferVisibleIcon", { fg = "#8be9fd", bg = "#262625" }) -- visible but not current
		vim.api.nvim_set_hl(0, "BufferInactiveIcon", { fg = "#056350", bg = "#262625" }) -- inactive buffer
	end,
}
