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
			auto_hide = false,
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

		local function apply_barbar_highlights()
			local is_light = vim.o.background == "light"

			if is_light then
				vim.api.nvim_set_hl(0, "BufferTabpageFill", { bg = "#ffffff" })
				vim.api.nvim_set_hl(0, "BufferCurrent", { bg = "#d0d0d0", fg = "#1a1a1a", bold = true })
				vim.api.nvim_set_hl(0, "BufferInactive", { bg = "#f0f0f0", fg = "#555555" })
				vim.api.nvim_set_hl(0, "BufferCurrentMod", { bg = "#51afae", fg = "#ffffff", bold = true })
				vim.api.nvim_set_hl(0, "BufferCurrentIcon", { fg = "#06bd95", bg = "#d0d0d0" })
				vim.api.nvim_set_hl(0, "BufferVisibleIcon", { fg = "#8be9fd", bg = "#f0f0f0" })
				vim.api.nvim_set_hl(0, "BufferInactiveIcon", { fg = "#056350", bg = "#f0f0f0" })
			else
				vim.api.nvim_set_hl(0, "BufferTabpageFill", { bg = "#1f1f1f" })
				vim.api.nvim_set_hl(0, "BufferCurrent", { bg = "#807e7a", fg = "#b8e3f5", bold = true })
				vim.api.nvim_set_hl(0, "BufferInactive", { bg = "#262625", fg = "#bbc2cf" })
				vim.api.nvim_set_hl(0, "BufferCurrentMod", { bg = "#51afae", fg = "#ffffff", bold = true })
				vim.api.nvim_set_hl(0, "BufferCurrentIcon", { fg = "#06bd95", bg = "#e8dfb0" })
				vim.api.nvim_set_hl(0, "BufferVisibleIcon", { fg = "#8be9fd", bg = "#262625" })
				vim.api.nvim_set_hl(0, "BufferInactiveIcon", { fg = "#056350", bg = "#262625" })
			end
		end

		-- Apply on startup
		apply_barbar_highlights()

		-- Reapply whenever the colorscheme changes (e.g. :Mode light / :Mode dark)
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = apply_barbar_highlights,
		})
	end,
}
