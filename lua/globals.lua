--place for globals, options, and configs
vim.g.mapleader = " " -- change the global Leader to space bar
vim.o.timeoutlen = 300
vim.o.number = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.expandtab = true -- Tab key 2 spaces (never real tabs)
vim.opt.shiftwidth = 2 -- >> and auto-indent = 2 columns
vim.opt.tabstop = 2 -- real \t characters display as 2 columns
vim.opt.softtabstop = 2 -- pressing Tab gives exactly 2 spaces
-- Use system clipboard for all yank, delete, change, and put operations
vim.opt.clipboard = "unnamedplus"
vim.opt.laststatus = 3 -- Use ONLY the global statusline — no local ones per split

vim.opt.undofile = true -- for undo/redo history
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo" -- optional: set a directory for undo files

-- Update diagnostic signs
vim.diagnostic.config({
	virtual_text = {
		-- Show virtual text only for errors
		severity = { min = vim.diagnostic.severity.ERROR },
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
	underline = true,
	update_in_insert = false,
})

vim.opt.cursorline = true -- highlights the current line
