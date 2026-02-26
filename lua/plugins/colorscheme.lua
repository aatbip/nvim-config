-- plugin/catppuccin.lua
-- This plugin is for the theme specs
return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		local catppuccin = require("catppuccin")

		-- =========================
		-- BASE (COMMON) CONFIG
		-- =========================
		local base_config = {
			background = {
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false,
			float = {
				transparent = false,
				solid = false,
			},
			show_end_of_buffer = false,
			term_colors = false,
			dim_inactive = {
				enabled = false,
				shade = "dark",
				percentage = 0.15,
			},
			no_italic = false,
			no_bold = false,
			no_underline = false,
			styles = {
				comments = { "italic" },
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
			},
			lsp_styles = {
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
				inlay_hints = { background = true },
			},
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
			},
		}

		-- =========================
		-- MODE-SPECIFIC OVERRIDES
		-- =========================
		local modes = {
			dark = {
				flavour = "mocha",
				color_overrides = {
					all = {
						base = "#1f1f1f",
						mantle = "#3f3e5c",
						crust = "#1f1f1f",
					},
				},
				custom_highlights = function(colors)
					return {
						Normal = { bg = "#1f1f1f" },
						Pmenu = { bg = "#1f1f1f" },

						NvimTreeNormal = { bg = "#1a1a1a" },
						NvimTreeWinSeparator = { fg = "#313244", bg = "#1a1a1a" },
						TelescopeNormal = { bg = "#1a1a1a" },
						TelescopeBorder = { fg = "#313244", bg = "#1a1a1a" },
						LazyNormal = { bg = "#1a1a1a" },
						LazyFloat = { bg = "#1a1a1a" },

						Comment = { fg = colors.green },
						TabLineSel = { bg = colors.pink },

						LineNr = { fg = colors.surface2 },
						CursorLineNr = { fg = colors.mauve, bold = true },

						FloatBorder = { fg = "#1f1f1f", bg = "#1f1f1f" },
						NormalFloat = { bg = "#2a2a2a" },
						HoverBorder = { fg = "#2a2a2a", bg = "#1f1f1f" },
						HoverNormal = { bg = "#1f1f1f" },
					}
				end,
			},

			light = {
				flavour = "latte",
				color_overrides = {
					all = {
						base = "#ffffff",
						mantle = "#f0f0f0",
						crust = "#e0e0e0",
					},
				},
				custom_highlights = function(colors)
					return {
						Normal = { bg = "#ffffff" },
						Pmenu = { bg = "#ffffff" },

						NvimTreeNormal = { bg = "#f5f5f5" },
						NvimTreeWinSeparator = { fg = "#cccccc", bg = "#f5f5f5" },
						TelescopeNormal = { bg = "#f5f5f5" },
						TelescopeBorder = { fg = "#cccccc", bg = "#f5f5f5" },
						LazyNormal = { bg = "#f5f5f5" },
						LazyFloat = { bg = "#f5f5f5" },

						Comment = { fg = colors.green },
						TabLineSel = { bg = colors.pink },

						LineNr = { fg = colors.surface2 },
						CursorLineNr = { fg = colors.mauve, bold = true },

						FloatBorder = { fg = "#ffffff", bg = "#ffffff" },
						NormalFloat = { bg = "#f0f0f0" },
					}
				end,
			},
		}

		local function apply_terminal_highlights(mode)
			local cp = require("catppuccin.palettes").get_palette(mode == "light" and "latte" or "mocha")

			if mode == "light" then
				vim.api.nvim_set_hl(0, "ToggleTermNormal", { bg = cp.base })
				vim.api.nvim_set_hl(0, "ToggleTermNormalFloat", { bg = cp.base })
				vim.api.nvim_set_hl(0, "ToggleTermBorder", { fg = cp.surface1, bg = cp.base })
			else
				vim.api.nvim_set_hl(0, "ToggleTermNormal", { bg = "#1a1a1a" })
				vim.api.nvim_set_hl(0, "ToggleTermNormalFloat", { bg = "#1a1a1a" })
				vim.api.nvim_set_hl(0, "ToggleTermBorder", { fg = cp.blue, bg = "#1a1a1a" })
			end
		end

		-- =========================
		-- APPLY MODE
		-- =========================
		local function apply_mode(mode)
			local cfg = vim.tbl_deep_extend("force", base_config, modes[mode] or modes.dark)

			catppuccin.setup(cfg)
			vim.cmd.colorscheme("catppuccin")
			apply_terminal_highlights(mode)
		end

		-- =========================
		-- USER COMMAND
		-- =========================
		vim.api.nvim_create_user_command("Mode", function(opts)
			if modes[opts.args] then
				apply_mode(opts.args)
				print("Catppuccin → " .. opts.args .. " mode")
			else
				print("Usage: :Mode light | dark")
			end
		end, { nargs = 1 })

		-- Default mode
		apply_mode("dark")
	end,
}
