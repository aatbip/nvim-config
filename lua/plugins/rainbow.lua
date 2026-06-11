-- ~/.config/nvim/lua/plugins/rainbow.lua
return {
	"HiPhish/rainbow-delimiters.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local rainbow = require("rainbow-delimiters")
		vim.g["rainbow_delimiters"] = {
			highlight = {
				"RainbowDelimiterTeal",
				"RainbowDelimiterPink",
				"RainbowDelimiterMauve",
				"RainbowDelimiterBlue",
				"RainbowDelimiterYellow",
				"RainbowDelimiterGreen",
				"RainbowDelimiterRed",
			},
		}
		-- wire the highlight groups to your catppuccin colors
		vim.api.nvim_set_hl(0, "RainbowDelimiterTeal", { fg = "#94e2d5" })
		vim.api.nvim_set_hl(0, "RainbowDelimiterPink", { fg = "#f5c2e7" })
		vim.api.nvim_set_hl(0, "RainbowDelimiterMauve", { fg = "#cba6f7" })
		vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#89b4fa" })
		vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#f9e2af" })
		vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#a6e3a1" })
		vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#f38ba8" })
	end,
}
