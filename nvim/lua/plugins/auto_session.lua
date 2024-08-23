return {
	"rmagatti/auto-session",
	lazy = false,
  commit = "50f5f2ea",
	opts = {
		log_level = "error",
		auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
		auto_session_enabled = true,
		auto_session_create_enabled = true,
		auto_session_enable_last_session = false,
		auto_session_suppress_dirs = { "~/", "~/Project", "~/Downloads", "/" },
		auto_save_enabled = true,
		auto_restore_enabled = true,
		auto_session_use_git_branch = false,
		bypass_session_save_file_types = nil,
		cwd_change_handling = {
			restore_upcoming_session = true,
			pre_cwd_changed_hook = nil,
			post_cwd_changed_hook = nil,
		},
	},
	config = function(_, opts)
    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

		require("auto-session").setup(opts)
		local auto_session_plugins = {
			splitterm = {
				state = false,
				save_index = 1,
				save_commands = {
					"exe '18SplitTerm'",
					'exe "normal! \\<C-w>W"',
				},
			},
			neotree = {
				state = false,
				save_index = 2,
				save_commands = {
					"exe 'Neotree'",
					'exe "normal! \\<C-w>W"',
				},
			},
			aerial = {
				state = false,
				save_index = 3,
				save_commands = { "exe 'AerialToggle!'" },
			},
			trouble = {
				state = false,
				save_index = 4,
				save_commands = { "exe 'Trouble diagnostics'" },
			},
		}

		function Find_buffer(pattern)
			local buffers = vim.api.nvim_list_bufs()
			for _, buf in ipairs(buffers) do
				local bufname = vim.api.nvim_buf_get_name(buf)
				if string.find(bufname, pattern) then
					return true
				end
			end
			print(pattern)
			return false
		end

		local function close_splitterm()
			if Find_buffer("SplitTerm") then
				vim.cmd("SplitTermClose")
				auto_session_plugins.splitterm.state = true
			end
		end
		local function close_neo_tree()
			if Find_buffer("tree filesystem") then
				vim.cmd("Neotree close")
				auto_session_plugins.neotree.state = true
			end
		end
		local function close_aerial()
			local aerial_api = require("aerial")
			if aerial_api.is_open() then
				aerial_api.close_all()
				auto_session_plugins.aerial.state = true
			end
		end
		local function close_trouble()
			local trouble_api = require("trouble")
			if trouble_api.is_open() then
				trouble_api.close()
				auto_session_plugins.trouble.state = true
			end
		end
		local function save_auto_session()
			local auto_session_root_dir = require("auto-session").get_root_dir()
			local cwd = string.gsub(vim.fn.getcwd(), "/", "%%")
			local auto_session_file_name = auto_session_root_dir .. cwd .. ".vim"
			local auto_session_file_io = io.open(auto_session_file_name, "a")
			if auto_session_file_io then
				local sorted_plugins = {}
				for _, plugin in pairs(auto_session_plugins) do
					table.insert(sorted_plugins, plugin)
				end
				table.sort(sorted_plugins, function(a, b)
					return a.save_index < b.save_index
				end)
				for _, plugin in ipairs(sorted_plugins) do
					if plugin.state then
						plugin.state = false
						for _, command in ipairs(plugin.save_commands) do
							auto_session_file_io:write(command .. "\n")
						end
					end
				end
				auto_session_file_io:close()
			else
				print("Failed to open file: " .. auto_session_file_name)
			end
		end
		vim.api.nvim_create_autocmd("ExitPre", {
			callback = function()
				close_splitterm()
				close_neo_tree()
				close_aerial()
				close_trouble()
			end,
		})
		vim.api.nvim_create_autocmd({ "VimLeave" }, { callback = save_auto_session })
	end,
}
