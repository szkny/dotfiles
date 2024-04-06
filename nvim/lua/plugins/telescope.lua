return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		cmd = { "Telescope" },
		keys = {
			{
				"<C-p>",
				"<CMD>Telescope find_files<CR>",
				mode = "n",
			},
			{
				"<C-f>",
				"<CMD>Telescope grep_string search=<CR>",
				mode = { "n", "v" },
			},
			{
				"<C-b>",
				"<CMD>Telescope buffers<CR>",
				mode = "n",
			},
			{
				"<Leader>m",
				"<CMD>Telescope marks<CR>",
				mode = "n",
			},
		},
		config = function()
			local actions = require("telescope.actions")
			local select_one_or_multi = function(prompt_bufnr)
				local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
				local multi = picker:get_multi_selection()
				if not vim.tbl_isempty(multi) then
					actions.close(prompt_bufnr)
					for _, j in pairs(multi) do
						if j.path ~= nil then
							vim.cmd(string.format("%s %s", "edit", j.path))
						end
					end
				else
					actions.select_default(prompt_bufnr)
				end
			end
			local select_one_or_multi_grep_string = function(prompt_bufnr)
				local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
				local multi = picker:get_multi_selection()
				if not vim.tbl_isempty(multi) then
					actions.send_selected_to_qflist(prompt_bufnr)
					actions.open_qflist(prompt_bufnr)
					vim.cmd("silent cfirst")
				else
					actions.select_default(prompt_bufnr)
				end
			end
			require("telescope").setup({
				defaults = {
					layout_strategy = "center",
					sorting_strategy = "ascending",
					layout_config = {
						center = {
							height = 0.4,
							preview_cutoff = 0,
							prompt_position = "top",
							width = 0.8,
						},
						horizontal = {
							height = 0.9,
							preview_cutoff = 120,
							prompt_position = "bottom",
							width = 0.8,
						},
						vertical = {
							height = 0.9,
							preview_cutoff = 40,
							prompt_position = "bottom",
							width = 0.8,
						},
					},
					mappings = {
						i = {
							["<CR>"] = select_one_or_multi,
							["<C-j>"] = actions.preview_scrolling_down,
							["<C-k>"] = actions.preview_scrolling_up,
						},
						n = {
							["<CR>"] = select_one_or_multi,
							["<C-j>"] = actions.preview_scrolling_down,
							["<C-k>"] = actions.preview_scrolling_up,
						},
					},
				},
				pickers = {
					grep_string = {
						mappings = {
							i = {
								["<CR>"] = select_one_or_multi_grep_string,
								["<C-j>"] = actions.preview_scrolling_down,
								["<C-k>"] = actions.preview_scrolling_up,
							},
							n = {
								["<CR>"] = select_one_or_multi_grep_string,
								["<C-j>"] = actions.preview_scrolling_down,
								["<C-k>"] = actions.preview_scrolling_up,
							},
						},
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
				},
			})
			require("telescope").load_extension("fzf")
		end,
	},
}
