return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			vim.opt.shortmess:append("I"),
			shuffle_letter = true,
			hide = {
				statusline = true,
				tabline = false,
				winbar = true,
			},
			config = {
				shortcut = {},
				header = {
					"                                                       ",
					"  1 0 1 $ % ^ & * ( ) _ + = [ ] { } | \\ / < > ~ # @ ! ",
					"  & * % 0 1 0 1 # @ $ ^ & * ( ) _ + = [ ] { } | \\ / < ",
					"  ^ & * ( m 1 0 1 - $ % ^ ^ * ( 0 1 + = [ ] 0 } | \\ / ",
					"  ! @ # $ % ^ & * ( ) _ + = [ ] { } | \\ / < > ~ 0 1 0 ",
					"  ! @ # $ % a y * ( ) a b = - ] u } @ %* / < > ~ 0 1 0 ",
					"  ^ & * ( ) 1 0 1| \\ / < >  ( ) 1 0 1| }0 1  1 |/ ~ # >",
					"  < > ~ 1 & 1 0 $ ( ^ & * ( ) _ + = [ ] { } | \\ / < > ",
					"  * ( ) _ + = 0 1 0 1 # @ $ % ^ & * ( ) _ + = [ ] { } ",
					"                                                       ",
				},
				packages = { enable = true }, -- show how many plugins neovim loaded
				project = {
					enable = true,
					limit = 10,
					icon = "⛧ ",
					label = "PROJECTS",
					action = "Telescope find_files cwd=",
				},
				mru = {
					enable = true,
					limit = 10,
					icon = "☢ ",
					label = "LATESTS",
					cwd_only = false,
				},
				footer = { "aatbip 2025" },
			},
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
