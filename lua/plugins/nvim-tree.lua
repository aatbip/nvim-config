-- file explorer
return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			update_focused_file = {
				enable = true,
				update_root = true, --change root when switching files
				ignore_list = {}, -- don't ignore anything
			},
			git = {
				ignore = false,
			},
		})
	end,
}
