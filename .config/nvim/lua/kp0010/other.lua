return {
	"alexghergh/nvim-tmux-navigation",
	{
		"kawre/leetcode.nvim",
		build = ":TSUpdate html",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			---@type lc.picker
			picker = { provider = telescope },
			---@type boolean
			image_support = true,
		},
	},
	{
		"3rd/image.nvim",
		build = false,
		opts = {
			processor = "magick_cli",
		},
		config = function()
			require("image").setup({
				backend = "kitty",
				processor = "magick_cli",
				tmux_show_only_in_active_window = true,
				editor_only_render_when_focused = true,
				window_overlap_clear_enabled = true,
				integrations = {
					html = {
						enabled = true,
					},
					css = {
						enabled = true,
					},
				},
			})
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function()
			require("which-key").setup()

			require("which-key").add({
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>d", group = "[D]ocument" },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>w", group = "[W]orkspace" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
			})
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		"kawre/leetcode.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()
			require("mini.pairs").setup()
			-- require("mini.indentscope").setup()
			-- require("mini.jump").setup()
			require("mini.splitjoin").setup()

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			-- and try some other statusline plugin
			-- local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			-- statusline.setup({ use_icons = vim.g.have_nerd_font })

			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			-- -@diagnostic disable-next-line: duplicate-set-field
			-- statusline.section_location = function()
			-- 	return "%2l:%-2v"
			-- end

			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},
	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
	},
	{
		"Goose97/alternative.nvim",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("alternative").setup({
				keymaps = {
					alternative_next = "<leader>]",
					alternative_prev = "<leader>[",
				},
				rules = {
					-- Built-in rules
					"general.boolean_flip",
					"general.number_increment_decrement",
					"javascript.ternary_to_if_else",
					"javascript.function_definition_variants",
					-- Built-in rules and override them
					["general.compare_operator_flip"] = { preview = true },
					-- Custom rules
					custom = {},
				},
			})
		end,
	},
}
