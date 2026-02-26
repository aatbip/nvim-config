-- -- ~/.config/nvim/lua/plugins/toggleterm.lua
-- return {
-- 	"akinsho/toggleterm.nvim",
-- 	version = "*",
-- 	keys = {
-- 		{ "<leader>\\", mode = { "n", "t" }, desc = "Toggle main terminal" },
-- 		{ "t1", "<cmd>1ToggleTerm<CR>", desc = "Terminal 1" },
-- 		{ "t2", "<cmd>2ToggleTerm<CR>", desc = "Terminal 2" },
-- 		{ "t3", "<cmd>3ToggleTerm<CR>", desc = "Terminal 3" },
-- 		{ "t4", "<cmd>4ToggleTerm<CR>", desc = "Terminal 4" },
-- 	},
-- 	opts = {
-- 		size = 16,
-- 		open_mapping = false,
-- 		start_in_insert = true,
-- 		direction = "horizontal",
-- 		close_on_exit = true,
-- 		shell = vim.o.shell,
-- 		float_opts = { border = "double" },
--
-- 		shade_terminals = false,
--
-- 		highlights = {
-- 			-- Main terminal background + foreground
-- 			Normal = {
-- 				guibg = "#1a1a1a",
-- 			},
-- 			NormalFloat = {
-- 				guibg = "#1a1a1a",
-- 			},
-- 			FloatBorder = {
-- 				guifg = "#89b4fa",
-- 				guibg = "#1e1e2e",
-- 			},
--
-- 			SignColumn = { guibg = "#1a1a1a" },
-- 			EndOfBuffer = { guifg = "#1a1a1a", guibg = "#1a1a1a" },
-- 		},
--
-- 		-- Show T1, T2, T3, T4 instead of ugly path
-- 		on_create = function(term)
-- 			local id = term.id
-- 			vim.api.nvim_buf_set_name(term.bufnr, "T" .. id)
-- 			vim.api.nvim_buf_set_option(term.bufnr, "buftype", "terminal")
-- 			vim.api.nvim_buf_set_option(term.bufnr, "filetype", "toggleterm")
-- 		end,
--
-- 		on_open = function(term)
-- 			vim.cmd("startinsert!")
-- 			-- Close with <leader>t from terminal mode
-- 			vim.keymap.set("t", "<leader>\\", "<cmd>close<CR>", {
-- 				buffer = term.bufnr,
-- 				silent = true,
-- 			})
-- 			vim.cmd("startinsert!")
-- 			vim.keymap.set("t", "<leader>\\", "<cmd>close<CR>", { buffer = term.bufnr, silent = true })
--
-- 			-- Fast escape with jj or jk
-- 			vim.keymap.set("t", "jj", [[<C-\><C-n>]], { buffer = term.bufnr })
-- 			-- or: vim.keymap.set("t", "jk", [[<C-\><C-n>]], { buffer = term.bufnr })
-- 		end,
-- 	},
--
-- 	config = function(_, opts)
-- 		local toggleterm = require("toggleterm")
-- 		toggleterm.setup(opts)
--
-- 		-- Smart <leader>t toggle
-- 		vim.keymap.set("n", "<leader>\\", function()
-- 			local term = require("toggleterm.terminal").get(1)
-- 			if term and term:is_open() then
-- 				term:close()
-- 			else
-- 				toggleterm.toggle(1, 16, vim.loop.cwd(), "horizontal")
-- 			end
-- 		end, { desc = "Toggle main terminal" })
-- 	end,
-- }

-- ~/.config/nvim/lua/plugins/toggleterm.lua
return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = {
		{ "<leader>\\", mode = { "n", "t" }, desc = "Toggle main terminal" },
		{ "<leader>l\\", desc = "Toggle vertical main terminal" },
		{ "t1", desc = "Terminal 1" },
		{ "t2", desc = "Terminal 2" },
		{ "t3", desc = "Terminal 3" },
		{ "t4", desc = "Terminal 4" },
		{ "tl1", desc = "Vertical Terminal 1" },
		{ "tl2", desc = "Vertical Terminal 2" },
		{ "tl3", desc = "Vertical Terminal 3" },
		{ "tl4", desc = "Vertical Terminal 4" },
	},
	opts = {
		size = 16,
		open_mapping = false,
		start_in_insert = true,
		direction = "horizontal",
		close_on_exit = true,
		shell = vim.o.shell,
		float_opts = { border = "double" },
		shade_terminals = false,
		-- highlights = {
		-- 	-- Main terminal background + foreground
		-- 	Normal = {
		-- 		guibg = "#1a1a1a",
		-- 	},
		-- 	NormalFloat = {
		-- 		guibg = "#1a1a1a",
		-- 	},
		-- 	FloatBorder = {
		-- 		guifg = "#89b4fa",
		-- 		guibg = "#1e1e2e",
		-- 	},
		-- 	SignColumn = { guibg = "#1a1a1a" },
		-- 	EndOfBuffer = { guifg = "#1a1a1a", guibg = "#1a1a1a" },
		-- },
		-- Show T1, T2, T3, T4 instead of ugly path
		on_create = function(term)
			local id = term.id
			vim.api.nvim_buf_set_name(term.bufnr, "T" .. id)
			vim.api.nvim_buf_set_option(term.bufnr, "buftype", "terminal")
			vim.api.nvim_buf_set_option(term.bufnr, "filetype", "toggleterm")
		end,
		on_open = function(term)
			vim.cmd("startinsert!")
			-- Close with <leader>t from terminal mode
			vim.keymap.set("t", "<leader>\\", "<cmd>close<CR>", {
				buffer = term.bufnr,
				silent = true,
			})
			-- Fast escape with jj or jk
			vim.keymap.set("t", "jj", [[<C-\><C-n>]], { buffer = term.bufnr })
			-- or: vim.keymap.set("t", "jk", [[<C-\><C-n>]], { buffer = term.bufnr })
		end,
	},
	config = function(_, opts)
		local toggleterm = require("toggleterm")
		toggleterm.setup(opts)

		local function smart_toggle(id, sz, dir)
			local Terminal = require("toggleterm.terminal")
			local term = Terminal.get(id)
			local was_open = term and term:is_open()
			-- Close all open terminals first to reset layout
			local all_terms = Terminal.get_all()
			for _, t in ipairs(all_terms) do
				if t:is_open() then
					t:close()
				end
			end
			-- If the target wasn't open, open it now in clean layout
			if not was_open then
				toggleterm.toggle(id, sz, vim.loop.cwd(), dir)
			end
		end

		-- Smart <leader>\ toggle (horizontal main)
		vim.keymap.set("n", "<leader>\\", function()
			smart_toggle(1, 16, "horizontal")
		end, { desc = "Toggle main terminal" })

		-- Vertical main terminal: <leader>l\
		local vertical_width = 80
		vim.keymap.set("n", "<leader>l\\", function()
			smart_toggle(1, vertical_width, "vertical")
		end, { desc = "Toggle vertical main terminal" })

		-- Horizontal numbered terminals: t1, t2, t3, t4
		for i = 1, 4 do
			vim.keymap.set("n", "t" .. i, function()
				smart_toggle(i, 16, "horizontal")
			end, { desc = "Terminal " .. i })
		end

		-- Vertical numbered terminals: tl1, tl2, tl3, tl4
		for i = 1, 4 do
			vim.keymap.set("n", "tl" .. i, function()
				smart_toggle(i, vertical_width, "vertical")
			end, { desc = "Vertical Terminal " .. i })
		end
	end,
}
