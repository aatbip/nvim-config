-- plugin/catppuccin.lua

-- Lazy.nvim plugin spec

return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000, -- load early
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			background = { -- :h background
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false, -- disables setting the background color.
			float = {
				transparent = false, -- enable transparent floating windows
				solid = false, -- use solid styling for floating windows, see |winborder|
			},
			show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
			term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
			dim_inactive = {
				enabled = false, -- dims the background color of inactive window
				shade = "dark",
				percentage = 0.15, -- percentage of the shade to apply to the inactive window
			},
			no_italic = false, -- Force no italic
			no_bold = false, -- Force no bold
			no_underline = false, -- Force no underline
			styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
				comments = { "italic" }, -- Change the style of comments
				conditionals = { "italic" },
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
				-- miscs = {}, -- Uncomment to turn off hard-coded styles
			},
			lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
					ok = { "italic" },
				},
				underlines = {
					errors = { "underline" },
					hints = { "underline" },
					warnings = { "underline" },
					information = { "underline" },
					ok = { "underline" },
				},
				inlay_hints = {
					background = true,
				},
			},
			color_overrides = {
				all = {
					-- make the background darker
					base = "#1f1f1f", -- main background
					mantle = "#3f3e5c", -- slightly darker
					crust = "#1f1f1f", -- darkest layer
				},
			},

			custom_highlights = function(colors)
				return {
					-- existing overrides
					Normal = { bg = "#1f1f1f" },
					Pmenu = { bg = "#1f1f1f" },

					-- file explorer & telescope
					NvimTreeNormal = { bg = "#1a1a1a" },
					NvimTreeWinSeparator = { fg = "#313244", bg = "#1a1a1a" },
					TelescopeNormal = { bg = "#1a1a1a" },
					TelescopeBorder = { fg = "#313244", bg = "#1a1a1a" },
					LazyNormal = { bg = "#1a1a1a" },
					LazyFloat = { bg = "#1a1a1a" },

					-- comments
					Comment = { fg = colors.green },

					-- tabline
					TabLineSel = { bg = colors.pink },

					LineNr = { fg = colors.surface2 }, -- normal line numbers
					CursorLineNr = { fg = colors.mauve, bold = true }, -- current line number colored & bold

					FloatBorder = { fg = "#1f1f1f", bg = "#1f1f1f" }, -- border of float windows
					NormalFloat = { bg = "#2a2a2a" }, -- background of float windows
					HoverBorder = { fg = "#2a2a2a", bg = "#1f1f1f" }, -- for lsp hover specifically
					HoverNormal = { bg = "#1f1f1f" }, -- for lsp hover specifically
				}
			end,
			default_integrations = true,
			auto_integrations = false,
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				notify = false,
				telescope = true,
				goto_preview = true,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
				-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
			},
		})

		-- Set the colorscheme
		vim.cmd.colorscheme("catppuccin")
	end,
}
