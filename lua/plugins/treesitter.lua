-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"HiPhish/rainbow-delimiters.nvim", -- rainbow plugin
	},
	config = function() -- forces full setup()
		require("nvim-treesitter.configs").setup({
			-- Install/ensure parsers
			ensure_installed = { "c", "cpp", "lua", "python", "bash" },

			-- Core modules — enable explicitly for c/cpp
			highlight = {
				enable = true, -- Syntax highlighting via Treesitter
				additional_vim_regex_highlighting = false, -- Disable Vim's old method
			},

			indent = {
				enable = true, -- Treesitter-based auto-indent
			},

			incremental_selection = {
				enable = true, -- <C-space> for smart selection
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					node_decremental = "<C-backspace>",
				},
			},

			-- Rainbow delimiters module
			rainbow = {
				enable = true,
				extended_mode = true, -- Color <> in templates too
				max_file_lines = nil, -- No limit for big files
				colors = {
					"#94e2d5", -- teal (level 1)
					"#f5c2e7", -- pink
					"#cba6f7", -- mauve
					"#89b4fa", -- blue
					"#f9e2af", -- yellow
					"#a6e3a1", -- green
					"#f38ba8", -- red
				},
			},
		})
	end,
}
