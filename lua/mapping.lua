vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
-- Clear search highlights
vim.keymap.set("n", "<leader>nh", ":nohlsearch<CR>", { desc = "Clear search highlights" })

local opts = { noremap = true, silent = true }
-- Go to definition
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

-- Peek definition in a floating window (like LSPSaga)
vim.keymap.set("n", "gp", vim.lsp.buf.hover, opts)

-- Open splits
vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<CR>", opts) -- horizontal split (left/right)
vim.keymap.set("n", "<leader>sh", "<cmd>split<CR>", opts) -- vertical split (top/bottom)

-- Toggle focus between splits: <leader>tt
vim.keymap.set("n", "<leader>tt", function()
	local wins = vim.api.nvim_tabpage_list_wins(0)
	local num_wins = #wins

	if num_wins == 1 then
		-- Single window? Open a vertical split
		vim.cmd("vsplit")
		return
	end

	local current_win = vim.api.nvim_get_current_win()

	-- Find the next window (simple cycle: current → next → first → repeat)
	local next_win = wins[1]
	for i, win in ipairs(wins) do
		if win == current_win then
			-- If not last, go to next; else go to first
			next_win = wins[i % num_wins + 1]
			break
		end
	end

	-- Switch focus
	vim.api.nvim_set_current_win(next_win)
end, { desc = "Toggle focus between splits" })
