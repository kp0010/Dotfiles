return {
	"mbbill/undotree",
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = { exclude = { filetypes = { "dashboard" } } },
	},
	{
		"rcarriga/nvim-notify",
		opts = {
			on_open = function(win)
				local config = vim.api.nvim_win_get_config(win)
				config.border = "single"
				vim.api.nvim_win_set_config(win, config)
			end,
		},
		config = function()
			require("notify").setup({
				background_colour = "#000000",
			})
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim",
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
					markdown = {
						enabled = true,
						download_remote_images = true,
						only_render_image_at_cursor = true,
						only_render_image_at_cursor_mode = "inline",
					},
					html = {
						enabled = true,
					},
					css = {
						enabled = false,
					},
				},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VimEnter",
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "moonfly",

					-- component_separators = { left = "", right = "" },
					-- section_separators = { left = "", right = "" },
					component_separators = { left = "|", right = "|" },
					section_separators = { left = " ", right = " " },
					-- component_separators = { left = "\\", right = "\\" },
					-- section_separators = { left = "", right = "" },

					disabled_filetypes = { "alpha", "neo-tree", "snacks_dashboard" },

					ignore_focus = {},
					always_divide_middle = true,
					globalstatus = false,
					refresh = {
						statusline = 1000,
						tabline = 1000,
						winbar = 1000,
					},
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { "filename" },

					lualine_x = {
						"encoding",
						"fileformat",
						"filetype",
						-- {
						-- require("noice").api.statusline.mode.get,
						-- cond = require("noice").api.statusline.mode.has,
						-- color = { fg = "#ff9e64" },
						-- },
					},
					lualine_y = { "progress" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = { "quickfix", "fugitive", "fzf" },
			})
		end,
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		keys = function()
			local keys = {
				{
					"<leader>cc",
					function()
						Snacks.scratch()
					end,
					desc = "Scratch pad",
				},
				{
					"<leader>cC",
					function()
						Snacks.scratch.select()
					end,
					desc = "Select scratch pad",
				},
			}
			if vim.g.picker_engine ~= "snacks" then
				return keys
			end
		end,
		opts = {
			-- debug = { enabled = true },
			indent = {
				enabled = true,
				animate = { enabled = true },
			},
			input = { enabled = true },
			notifier = {
				enabled = true,
				style = "minimal",
			},
			styles = {
				notification_history = {
					keys = { ["<esc>"] = "close" },
				},
			},
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd -- Override print to use snacks for `:=` command

					-- Create some toggle mappings
					Snacks.toggle
						.option("background", { off = "light", on = "dark", name = "dark background" })
						:map("<leader>vb")
					Snacks.toggle.option("foldcolumn", { off = "0", on = "1", name = "foldcolumn" }):map("<leader>vz")
					Snacks.toggle.option("cursorline", { name = "cursorline" }):map("<leader>vc")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>vw")
					Snacks.toggle.inlay_hints():map("<leader>vH")
					Snacks.toggle.diagnostics():map("<leader>vd")
					Snacks.toggle.indent():map("<leader>vi")

					-- Toggle the profiler
					Snacks.toggle.profiler():map("<leader>cp")
					-- Toggle the profiler highlights
					Snacks.toggle.profiler_highlights():map("<leader>vP")
				end,
			})
		end,
	},
	{
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = { -- set to setup table
		},
	},
	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		require("noice").setup({
	-- 			require("noice").setup({
	-- 				messages = {
	-- 					view = "notify",
	-- 					view_error = "notify",
	-- 				},
	-- 				lsp = {
	-- 					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
	-- 					override = {
	-- 						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	-- 						["vim.lsp.util.stylize_markdown"] = true,
	-- 						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
	-- 					},
	-- 				},
	-- 				-- you can enable a preset for easier configuration
	-- 				presets = {
	-- 					bottom_search = true, -- use a classic bottom cmdline for search
	-- 					command_palette = false, -- position the cmdline and popupmenu together
	-- 					long_message_to_split = true, -- long messages will be sent to a split
	-- 					inc_rename = false, -- enables an input dialog for inc-rename.nvim
	-- 					lsp_doc_border = false, -- add a border to hover docs and signature help
	-- 				},
	-- 				routes = {
	-- 					{
	-- 						view = "notify",
	-- 						filter = { event = "msg_showmode" },
	-- 					},
	-- 				},
	-- 			}),
	-- 		})
	-- 	end,
	-- 	opts = {},
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- 	presets = { inc_rename = true },
	-- },
	-- {
	-- 	"shellRaining/hlchunk.nvim",
	-- 	event = { "BufReadPre", "BufNewFile" },
	-- 	config = function()
	-- 		require("hlchunk").setup({
	-- 			chunk = {
	-- 				enable = true,
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
