-- ~/.config/nvim/lua/plugins/persistence.lua
return {
	"folke/persistence.nvim",
	event = "BufReadPre", -- load before reading files
	opts = {
		dir = vim.fn.stdpath("state") .. "/sessions/", -- saves to ~/.local/state/nvim/sessions/
		options = { "buffers", "curdir", "tabpages", "winsize", "globals" }, -- remember everything
		pre_save = function()
			-- close barbar tabs cleanly
			vim.api.nvim_exec_autocmds("User", { pattern = "SessionSavePre" })
		end,
	},
	config = function(_, opts)
		require("persistence").setup(opts)

		-- optional: nice startup message
		vim.api.nvim_create_autocmd("User", {
			pattern = "PersistenceLoadPost",
			callback = function()
				vim.notify("Session restored", vim.log.levels.INFO)
			end,
		})
	end,

	keys = {
		{
			"<leader>qs",
			function()
				require("persistence").load()
			end,
			desc = "Restore session",
		},
		{
			"<leader>ql",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "Restore last session",
		},
		{
			"<leader>qd",
			function()
				require("persistence").stop()
			end,
			desc = "Don't save session on exit",
		},
	},
}
