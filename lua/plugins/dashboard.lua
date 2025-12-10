return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons", "nvim-telescope/telescope.nvim" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local pickers = require("telescope.pickers")
		local finders = require("telescope.finders")
		local conf = require("telescope.config").values
		local actions = require("telescope.actions")
		local action_state = require("telescope.actions.state")
		local uv = vim.loop

		-- ======= Banner =======
		local banner = {
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
		}
		dashboard.section.header.val = banner

		-- ======= Recent folders function (filtered) =======
		local function recent_folders()
			local oldfiles = vim.v.oldfiles
			local dirs = {}
			local seen = {}
			local allowed_roots = { vim.fn.expand("~/Projects") .. "/", vim.fn.expand("~/Learnings") .. "/" }

			local function is_allowed(path)
				for _, root in ipairs(allowed_roots) do
					if vim.startswith(path, root) then
						return true
					end
				end
				return false
			end

			for _, file in ipairs(oldfiles) do
				local dir = vim.fn.isdirectory(file) == 1 and file or vim.fn.fnamemodify(file, ":h")
				if vim.fn.isdirectory(dir) == 1 and not seen[dir] and is_allowed(dir) then
					seen[dir] = true
					table.insert(dirs, dir)
				end
			end

			pickers
				.new({}, {
					prompt_title = "Recent Folders",
					finder = finders.new_table({
						results = dirs,
					}),
					sorter = conf.generic_sorter({}),
					attach_mappings = function(prompt_bufnr, map)
						actions.select_default:replace(function()
							actions.close(prompt_bufnr)
							local selection = action_state.get_selected_entry()
							vim.cmd("edit " .. vim.fn.fnameescape(selection[1]))
						end)
						return true
					end,
				})
				:find()
		end

		-- ======= Projects + Learnings folders function (recent first) =======
		local function open_projects_learnings()
			local roots = {
				vim.fn.expand("~/Projects"),
				vim.fn.expand("~/Learnings"),
			}

			local top_level_folders = {}

			-- gather all top-level folders
			for _, root in ipairs(roots) do
				local handle = vim.loop.fs_scandir(root)
				if handle then
					while true do
						local name, type = vim.loop.fs_scandir_next(handle)
						if not name then
							break
						end
						if type == "directory" then
							local path = root .. "/" .. name
							top_level_folders[path] = true
						end
					end
				end
			end

			-- collect recently opened top-level folders first (newest first)
			local recent = {}
			local seen = {}
			for i = 1, #vim.v.oldfiles do
				local file = vim.v.oldfiles[i]
				local dir = vim.fn.isdirectory(file) == 1 and file or vim.fn.fnamemodify(file, ":p:h")
				for top, _ in pairs(top_level_folders) do
					if dir == top and not seen[top] then
						table.insert(recent, top) -- insert at end
						seen[top] = true
					end
				end
			end

			-- remaining folders (not recently opened)
			local remaining = {}
			for path, _ in pairs(top_level_folders) do
				if not seen[path] then
					table.insert(remaining, path)
				end
			end

			local final_list = vim.list_extend(recent, remaining)
			-- show in telescope
			require("telescope.pickers")
				.new({}, {
					prompt_title = "Projects + Learnings",
					finder = require("telescope.finders").new_table({
						results = final_list,
					}),
					sorter = require("telescope.config").values.generic_sorter({}),
					attach_mappings = function(prompt_bufnr, map)
						local actions = require("telescope.actions")
						local action_state = require("telescope.actions.state")
						actions.select_default:replace(function()
							actions.close(prompt_bufnr)
							local selection = action_state.get_selected_entry()
							vim.cmd("edit " .. vim.fn.fnameescape(selection[1]))
						end)
						return true
					end,
				})
				:find()
		end

		-- ======= Buttons =======
		dashboard.section.buttons.val = {
			dashboard.button("p", "♚ Lab", open_projects_learnings),
			dashboard.button("f", "☢ Latest Folders", recent_folders),
			dashboard.button("n", " New File", ":ene!<CR>"),
			dashboard.button("r", " Recent files", ":Telescope oldfiles<CR>"),
			dashboard.button("t", " Find Text", ":Telescope live_grep<CR>"),
			dashboard.button("c", " Config", function()
				vim.cmd("edit " .. vim.fn.expand("~/.config/nvim"))
			end),
			dashboard.button("Q", " Quit", ":qa<CR>"),
		}

		-- ======= Footer =======
		dashboard.section.footer.val = { "aatbip 2025" }

		-- ======= Setup =======
		alpha.setup(dashboard.config)
	end,
}
