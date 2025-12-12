return {
	"Aasim-A/scrollEOF.nvim",
	event = { "CursorMoved", "WinScrolled" },
	opts = {
		pattern = "*", -- apply to all buffers
		insert_mode = true, -- enable in insert mode
		floating = true, -- enable in floating windows
		disabled_filetypes = { "terminal" },
		disabled_modes = { "t", "nt" },
	},
}
