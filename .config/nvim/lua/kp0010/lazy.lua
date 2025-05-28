vim.g.mapleader = " "
vim.g.maplocalleader = " "
-----------------------------------------------------------------------

-- [[ Install `lazy.nvim` plugin manager ]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
-------------------------------------------------------------------------------------------------

-- [[ Configure and install plugins ]]

require("lazy").setup({
	-- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

	-- Themes
	"sainnhe/gruvbox-material",
	"shaunsingh/nord.nvim",
	"navarasu/onedark.nvim",
	"ficcdaf/ashen.nvim",
	"rebelot/kanagawa.nvim",
	"projekt0n/github-nvim-theme",

	"nvim-lua/plenary.nvim",
	"nvim-telescope/telescope.nvim",
	"nvim-treesitter/nvim-treesitter",
	"ahmedkhalf/project.nvim",
	"mbbill/undotree",
	"tpope/vim-fugitive",

	-- NOTE: Plugins can also be added by using a table,
	-- with the first argument being the link and the following
	-- keys can be used to configure plugin behavior/loading/etc.
	--
	-- Use `opts = {}` to force a plugin to be loaded.
	--

	-- Here is a more advanced example where we pass configuration
	-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
	--    require('gitsigns').setup({ ... })
	--
	-- See `:help gitsigns` to understand what the configuration keys do
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	-------------------------------------------------------------------------------------------------
	{
		"chrisgrieser/nvim-spider",
		keys = {
			{
				"e",
				"<cmd>lua require('spider').motion('e')<CR>",
				mode = { "n", "o", "x" },
			},
			-- ...
		},
	},
	-------------------------------------------------------------------------------------------------
	{
		"rcarriga/nvim-notify",
		opts = {
			on_open = function(win)
				local config = vim.api.nvim_win_get_config(win)
				config.border = "single"
				vim.api.nvim_win_set_config(win, config)
			end,
		},
	},
	-------------------------------------------------------------------------------------------------
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		config = function()
			require("noice").setup({
				require("noice").setup({
					messages = {
						view = "notify",
						view_error = "notify",
					},
					lsp = {
						-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
						override = {
							["vim.lsp.util.convert_input_to_markdown_lines"] = true,
							["vim.lsp.util.stylize_markdown"] = true,
							["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
						},
					},
					-- you can enable a preset for easier configuration
					presets = {
						bottom_search = true, -- use a classic bottom cmdline for search
						command_palette = false, -- position the cmdline and popupmenu together
						long_message_to_split = true, -- long messages will be sent to a split
						inc_rename = false, -- enables an input dialog for inc-rename.nvim
						lsp_doc_border = false, -- add a border to hover docs and signature help
					},
					-- routes = {
					-- 	{
					-- 		view = "notify",
					-- 		filter = { event = "msg_showmode" },
					-- 	},
					-- },
				}),
			})
		end,
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		presets = { inc_rename = true },
	},
	-------------------------------------------------------------------------------------------------
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
	-------------------------------------------------------------------------------------------------
	{
		"alexghergh/nvim-tmux-navigation",
	},
	-------------------------------------------------------------------------------------------------
	{
		"OXY2DEV/markview.nvim",
		lazy = false, -- Recommended
		-- ft = "markdown" -- If you decide to lazy-load anyway

		dependencies = {
			-- You will not need this if you installed the
			-- parsers manually
			-- Or if the parsers are in your $RUNTIMEPATH
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("markview").setup({

				latex = {
					enable = true,

					--- Bracket conceal configuration.
					--- Shows () in specific cases
					paranthesis = {
						enable = true,

						--- Highlight group for the ()
						---@type string
						hl = "@punctuation.paranthesis",
					},

					--- LaTeX blocks renderer
					blocks = {
						enable = true,

						--- Highlight group for the block
						---@type string
						hl = "Code",

						--- Virtual text to show on the bottom
						--- right.
						--- First value is the text and second value
						--- is the highlight group.
						---@type string[]
						text = { " LaTeX ", "Special" },
					},

					--- Configuration for inline LaTeX maths
					inlines = {
						enable = true,
					},
				},
			})
		end,
	},
	-------------------------------------------------------------------------------------------------
	-- {
	-- 	"iamcco/markdown-preview.nvim",
	-- 	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	-- 	build = "cd app && yarn install",
	-- 	init = function()
	-- 		vim.g.mkdp_filetypes = { "markdown" }
	-- 	end,
	-- 	ft = { "markdown" },
	-- },
	-- {
	-- 	"MeanderingProgrammer/render-markdown.nvim",
	-- 	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
	-- 	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
	-- 	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
	-- 	---@module 'render-markdown'
	-- 	---@type render.md.UserConfig
	-- 	opts = {},
	-- },
	-------------------------------------------------------------------------------------------------
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
			})
		end,
	},
	-------------------------------------------------------------------------------------------------
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		config = function()
			require("oil").setup({
				columns = {
					"icon",
					-- "permissions",
					-- "size",
					-- "mtime",
				},
				win_options = {
					wrap = false,
					signcolumn = "yes",
					cursorcolumn = false,
					foldcolumn = "0",
					spell = false,
					list = false,
					conceallevel = 3,
					concealcursor = "nvic",
				},
				keymaps = {
					["g?"] = { "actions.show_help", mode = "n" },
					["<CR>"] = "actions.select",
					["<C-s>"] = { "actions.select", opts = { vertical = true } },
					["<C-v>"] = { "actions.select", opts = { horizontal = true } },
					["<C-t>"] = { "actions.select", opts = { tab = true } },
					["<C-p>"] = "actions.preview",
					["<C-c>"] = { "actions.close", mode = "n" },
					["<C-r>"] = "actions.refresh",
					["-"] = { "actions.parent", mode = "n" },
					["_"] = { "actions.open_cwd", mode = "n" },
					["`"] = { "actions.cd", mode = "n" },
					["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
					["gs"] = { "actions.change_sort", mode = "n" },
					["gx"] = "actions.open_external",
					["g."] = { "actions.toggle_hidden", mode = "n" },
					["g\\"] = { "actions.toggle_trash", mode = "n" },
				},
				use_default_keymaps = false,
			})
		end,
	},
	-------------------------------------------------------------------------------------------------
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	-------------------------------------------------------------------------------------------------
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon").setup({
				settings = {
					save_on_toggle = true,
					sync_on_ui_close = true,
					key = function()
						return vim.loop.cwd()
					end,
				},
			})
		end,
	},
	-------------------------------------------------------------------------------------------------
	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup({})
		end,
	},
	-------------------------------------------------------------------------------------------------
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = { exclude = { filetypes = { "dashboard" } } },
	},
	-------------------------------------------------------------------------------------------------
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
	},
	-------------------------------------------------------------------------------------------------
	-- {
	-- "nvimdev/dashboard-nvim",
	-- event = "VimEnter",
	-- config = function()
	-- 	-- require("dashboard").setup({ header = "HELLO KP" })
	-- 	require("dashboard").setup({
	-- 		theme = "hyper",
	-- 		config = {
	-- 			header = {
	-- 				-- "HELLO KP"
	-- 				-- [[  ___ ______________.____    .____    ________     ____  __.__________ ]],
	-- 				-- [[ /   |   \_   _____/|    |   |    |   \_____  \   |    |/ _|\______   \]],
	-- 				-- [[/    ~    \    __)_ |    |   |    |    /   |   \  |      <   |     ___/]],
	-- 				-- [[\    Y    /        \|    |___|    |___/    |    \ |    |  \  |    |    ]],
	-- 				-- [[ \___|_  /_______  /|_______ \_______ \_______  / |____|__ \ |____|    ]],
	-- 				-- [[       \/        \/         \/       \/       \/          \/           ]],
	-- 				-- [[]],
	-- 				-- [[]],
	-- 				[[]],
	-- 				[[]],
	-- 				[[ ____  __.__________ _______   _______    ____ _______   ]],
	-- 				[[|    |/ _|\______   \\   _  \  \   _  \  /_   |\   _  \  ]],
	-- 				[[|      <   |     ___//  /_\  \ /  /_\  \  |   |/  /_\  \ ]],
	-- 				[[|    |  \  |    |    \  \_/   \\  \_/   \ |   |\  \_/   \]],
	-- 				[[|____|__ \ |____|     \_____  / \_____  / |___| \_____  /]],
	-- 				[[        \/                  \/        \/              \/ ]],
	-- 				[[]],
	-- 				[[]],
	-- 			},
	-- 			week_header = {
	-- 				enable = false,
	-- 			},
	-- 			shortcut = {
	-- 				{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
	-- 				{
	-- 					icon = " ",
	-- 					icon_hl = "@variable",
	-- 					desc = "Files",
	-- 					group = "Label",
	-- 					action = "Telescope find_files",
	-- 					key = "f",
	-- 				},
	-- 				-- {
	-- 				-- 	desc = " Apps",
	-- 				-- 	group = "DiagnosticHint",
	-- 				-- 	action = "Telescope app",
	-- 				-- 	key = "a",
	-- 				-- },
	-- 				-- {
	-- 				-- 	desc = " Dotfiles",
	-- 				-- 	group = "Number",
	-- 				-- 	action = "Telescope dotfiles",
	-- 				-- 	key = "d",
	-- 				-- },
	-- 			},
	-- 		},
	-- 	})
	-- end,
	-- dependencies = { { "nvim-tree/nvim-web-devicons" } },
	-- },
	-------------------------------------------------------------------------------------------------
	{
		"goolord/alpha-nvim",
		event = "VimEnter", -- load plugin after all configuration is set
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- NOTE: Enable if needed
		},
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			local header = {
				-- [[                                                                       ]],
				-- [[                                                                       ]],
				-- [[                                                                       ]],
				-- [[                                                                       ]],
				-- [[                                                                       ]],
				-- [[                                                                     ]],
				-- [[       ████ ██████           █████      ██                     ]],
				-- [[      ███████████             █████                             ]],
				-- [[      █████████ ███████████████████ ███   ███████████   ]],
				-- [[     █████████  ███    █████████████ █████ ██████████████   ]],
				-- [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
				-- [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
				-- [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
				-- [[                                                                       ]],
				-- [[                                                                       ]],
				-- [[                                                                       ]],
				--
				[[]],
				[[]],
				[[]],
				[[]],
				[[                                                          ]],
				[[                                                          ]],
				[[ ████ ██ ███████████████  ██████  ████ ██████  ]],
				[[ ███████    █████████ ██ ██ ██  ████ ██ ██ ]],
				[[ ████ ███   ████     ██ █████ ███ ████ ██ ███]],
				[[ ████ ████  ████      ███████ ███████ ████  ███████]],
				[[                                                  ]],
				[[]],
				[[]],
				[[]],
				[[]],
				[[]],
			}

			dashboard.section.header.val = header

			dashboard.section.buttons.val = {
				dashboard.button("p", "   Find Project", ":Telescope projects<CR>"),
				dashboard.button("f", "   Find File", ":Telescope find_files previewer=true<CR>"),
				dashboard.button("l", "   Leetcode", ":Leet<CR>"),
				dashboard.button("r", "   Recent", ":Telescope oldfiles<CR>"),
				dashboard.button("n", "   Config", function()
					require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
				end),
				dashboard.button("z", "󰒲   Lazy", ":Lazy<CR>"),
				dashboard.button("m", "󱌣   Mason", ":Mason<CR>"),
				dashboard.button("q", "   Quit NVIM", ":qa<CR>"),
			}

			-- set highlight groups
			vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#ffffff" })
			dashboard.section.header.opts.hl = "DashboardHeader"

			vim.api.nvim_set_hl(0, "DashboardFooterNormal", { fg = "#ffffff" }) -- White (default)
			-- vim.api.nvim_set_hl(0, "DashboardFooterOrange", { fg = "#ffa500" }) -- Orange for > 50ms
			-- vim.api.nvim_set_hl(0, "DashboardFooterRed", { fg = "#D9534F" }) -- Red for > 60ms

			vim.api.nvim_set_hl(0, "DashboardButtonKey", { fg = "#ffffff", bold = true }) -- Key color
			vim.api.nvim_set_hl(0, "DashboardButtonText", { fg = "#ffffff" }) -- text color

			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl_shortcut = "DashboardButtonKey" -- Apply to key (e.g., "e", "f")
				button.opts.hl = "DashboardButtonText" -- Apply to the text (e.g., "File explorer")
			end

			dashboard.opts.opts.noautocmd = true -- This prevents any unwanted autocommands (e.g., BufRead, BufEnter)

			alpha.setup(dashboard.opts) -- setup

			vim.api.nvim_create_autocmd("User", { -- Measure start up time
				pattern = "LazyVimStarted",
				callback = function()
					local plugins = require("lazy").stats()
					local time = (math.floor(plugins.startuptime * 100) / 100)
					local footer_hl = "DashboardFooterNormal" -- Default white

					if time > 60 then
						footer_hl = "DashboardFooterRed" -- Red if > 60ms
					elseif time > 50 then
						footer_hl = "DashboardFooterOrange" -- Orange if > 50ms
					end

					dashboard.section.footer.opts.hl = footer_hl

					dashboard.section.footer.val = {
						" ",
						" ",
						" ",
						"󱐌 " .. plugins.count .. " plugins loaded in " .. time .. " ms",
					}
					pcall(vim.cmd.AlphaRedraw)
				end,
			})
		end,
	},
	-------------------------------------------------------------------------------------------------
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
	},
	-------------------------------------------------------------------------------------------------
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
					-- component_separators = { left = "|", right = "|" },
					-- section_separators = { left = " ", right = " " },
					component_separators = { left = "\\", right = "\\" },
					section_separators = { left = "", right = "" },

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
						{
							require("noice").api.statusline.mode.get,
							cond = require("noice").api.statusline.mode.has,
							color = { fg = "#ff9e64" },
						},
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
	-- {
	-- 	"nvim-lualine/lualine.nvim",
	-- 	enabled = vim.o.laststatus ~= 0,
	-- 	dependencies = {
	-- 		{
	-- 			"cameronr/lualine-pretty-path",
	-- 			-- dev = true,
	-- 		},
	-- 	},
	-- 	-- config = function(_, opts)
	-- 	opts = function()
	-- 		local lazy_status = require("lazy.status") -- to configure lazy pending updates count
	--
	-- 		--- From: https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets
	-- 		--- @param trunc_width number trunctates component when screen width is less then trunc_width
	-- 		--- @param trunc_len number truncates component to trunc_len number of chars
	-- 		--- @param hide_width number hides component when window width is smaller then hide_width
	-- 		--- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
	-- 		--- return function that can format the component accordingly
	-- 		local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
	-- 			return function(str)
	-- 				local win_width = vim.o.columns
	-- 				if hide_width and win_width < hide_width then
	-- 					return ""
	-- 				elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
	-- 					return str:sub(1, trunc_len) .. (no_ellipsis and "" or "…")
	-- 				end
	-- 				return str
	-- 			end
	-- 		end
	--
	-- 		-- Show LSP status, borrowed from Heirline cookbook
	-- 		-- https://github.com/rebelot/heirline.nvim/blob/master/cookbook.md#lsp
	-- 		local function lsp_status_all()
	-- 			local haveServers = false
	-- 			local names = {}
	-- 			for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
	-- 				-- msg = ' '
	-- 				haveServers = true
	-- 				table.insert(names, server.name)
	-- 			end
	-- 			if not haveServers then
	-- 				return ""
	-- 			end
	-- 			if vim.g.custom_lualine_show_lsp_names then
	-- 				return " " .. table.concat(names, ",")
	-- 			end
	-- 			return " "
	-- 		end
	--
	-- 		-- Override 'encoding': Don't display if encoding is UTF-8.
	-- 		local encoding_only_if_not_utf8 = function()
	-- 			local ret, _ = (vim.bo.fenc or vim.go.enc):gsub("^utf%-8$", "")
	-- 			return ret
	-- 		end
	-- 		-- fileformat: Don't display if &ff is unix.
	-- 		local fileformat_only_if_not_unix = function()
	-- 			local ret, _ = vim.bo.fileformat:gsub("^unix$", "")
	-- 			return ret
	-- 		end
	--
	-- 		Snacks.toggle({
	-- 			name = "lualine symbols",
	-- 			get = function()
	-- 				return vim.b.trouble_lualine ~= false
	-- 			end,
	-- 			set = function(state)
	-- 				vim.b.trouble_lualine = state
	-- 			end,
	-- 		}):map("<leader>vl")
	--
	-- 		Snacks.toggle({
	-- 			name = "lualine lsp names",
	-- 			get = function()
	-- 				return vim.g.custom_lualine_show_lsp_names
	-- 			end,
	-- 			set = function(state)
	-- 				vim.g.custom_lualine_show_lsp_names = state
	-- 			end,
	-- 		}):map("<leader>vL")
	--
	-- 		Snacks.toggle({
	-- 			name = "lualine session name",
	-- 			get = function()
	-- 				return vim.g.custom_lualine_show_session_name
	-- 			end,
	-- 			set = function(state)
	-- 				vim.g.custom_lualine_show_session_name = state
	-- 			end,
	-- 		}):map("<leader>vs")
	--
	-- 		return {
	-- 			options = {
	-- 				-- When theme is set to auto, Lualine uses dofile instead of require
	-- 				-- to load the theme. We need the theme to be loaded via require since
	-- 				-- we modify the cached singleton in tokyonight's config function to
	-- 				-- add different colors for the x section
	-- 				theme = function()
	-- 					if vim.g.colors_name:match("^tokyonight") then
	-- 						return require("lualine.themes." .. vim.g.colors_name)
	-- 					end
	-- 					-- fall through case just needed for telescope theme browser
	-- 					return require("lualine.utils.loader").load_theme("auto")
	-- 				end,
	-- 				component_separators = { left = "╲", right = "╱" },
	-- 				disabled_filetypes = { "alpha", "neo-tree", "snacks_dashboard" },
	-- 				section_separators = { left = "", right = "" },
	-- 				ignore_focus = { "trouble" },
	-- 				globalstatus = true,
	-- 			},
	-- 			sections = {
	-- 				lualine_a = {
	-- 					{
	-- 						"mode",
	-- 						fmt = trunc(130, 3, 0, true),
	-- 					},
	-- 				},
	-- 				lualine_b = {
	-- 					{
	-- 						"branch",
	-- 						fmt = trunc(70, 15, 65, true),
	-- 						separator = "",
	-- 					},
	-- 				},
	-- 				-- lualine_c = {
	-- 				-- 	{
	-- 				-- 		"pretty_path",
	-- 				-- 		providers = {
	-- 				-- 			default = require("util.pretty_path_harpoon"),
	-- 				-- 		},
	-- 				-- 		directories = {
	-- 				-- 			max_depth = 4,
	-- 				-- 		},
	-- 				-- 		highlights = {
	-- 				-- 			newfile = "LazyProgressDone",
	-- 				-- 		},
	-- 				-- 		separator = "",
	-- 				-- 	},
	-- 				-- },
	-- 				lualine_x = {
	-- 					{
	-- 						function()
	-- 							return require("auto-session.lib").current_session_name(true)
	-- 						end,
	-- 						cond = function()
	-- 							return vim.g.custom_lualine_show_session_name
	-- 						end,
	-- 					},
	-- 					{
	-- 						"diagnostics",
	-- 						-- symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
	-- 						symbols = { error = " ", warn = " ", info = " ", hint = " " },
	-- 						separator = "",
	-- 					},
	-- 					{
	-- 						"diff",
	-- 						symbols = {
	-- 							added = " ",
	-- 							modified = " ",
	-- 							removed = " ",
	-- 						},
	-- 						fmt = trunc(0, 0, 60, true),
	-- 						separator = "",
	-- 					},
	-- 					{
	-- 						function()
	-- 							return "recording @" .. vim.fn.reg_recording()
	-- 						end,
	-- 						cond = function()
	-- 							return vim.fn.reg_recording() ~= ""
	-- 						end,
	-- 						color = { fg = "#ff007c" },
	-- 						separator = "",
	-- 					},
	-- 					{
	-- 						lazy_status.updates,
	-- 						cond = lazy_status.has_updates,
	-- 						-- color = { fg = '#3d59a1' },
	-- 						fmt = trunc(0, 0, 160, true), -- hide when window is < 100 columns
	-- 						separator = "",
	-- 					},
	--
	-- 					-- require("util.lualine").cmp_source("supermaven", "󰰣"),
	--
	-- 					{
	-- 						lsp_status_all,
	-- 						fmt = trunc(0, 8, 140, false),
	-- 						separator = "",
	-- 					},
	-- 					{
	-- 						encoding_only_if_not_utf8,
	-- 						fmt = trunc(0, 0, 140, true), -- hide when window is < 80 columns
	-- 						separator = "",
	-- 					},
	-- 					{
	-- 						fileformat_only_if_not_unix,
	-- 						fmt = trunc(0, 0, 140, true), -- hide when window is < 80 columns
	-- 						separator = "",
	-- 					},
	-- 				},
	-- 				lualine_y = {
	-- 					{ "progress", fmt = trunc(0, 0, 40, true) },
	-- 				},
	-- 				lualine_z = {
	-- 					{ "location", fmt = trunc(0, 0, 80, true) },
	-- 				},
	-- 			},
	-- 			inactive_sections = {
	-- 				lualine_c = {
	-- 					-- {
	-- 					-- 	"pretty_path",
	-- 					-- 	"filename",
	-- 					-- 	symbols = {
	-- 					-- 		modified = "+", -- Text to show when the file is modified.
	-- 					-- 		readonly = "", -- Text to show when the file is non-modifiable or readonly.
	-- 					-- 	},
	-- 					-- },
	-- 				},
	-- 			},
	-- 			extensions = {
	-- 				"lazy",
	-- 				"mason",
	-- 				"neo-tree",
	-- 				"nvim-dap-ui",
	-- 				"oil",
	-- 				"quickfix",
	-- 				"toggleterm",
	-- 				"trouble",
	-- 			},
	-- 		}
	-- 	end,
	-- },
	-------------------------------------------------------------------------------------------------
	-- {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		keys = function()
			local keys = {
				-- 					-- {
				-- 					-- 	"[l",
				-- 					-- 	function()
				-- 					-- 		Snacks.words.jump(-1, true)
				-- 					-- 	end,
				-- 					-- 	desc = "Next LSP highlight",
				-- 					-- },
				-- 					-- {
				-- 					-- 	"]l",
				-- 					-- 	function()
				-- 					-- 		Snacks.words.jump(1, true)
				-- 					-- 	end,
				-- 					-- 	desc = "Next LSP highlight",
				-- 					-- },
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
				-- 					-- {
				-- 					-- 	"<leader>sp",
				-- 					-- 	function()
				-- 					-- 		Snacks.notifier.show_history({ reverse = true })
				-- 					-- 	end,
				-- 					-- 	desc = "Show notifs",
				-- 					-- },
				-- 					-- {
				-- 					-- 	"<leader>wp",
				-- 					-- 	function()
				-- 					-- 		Snacks.notifier.hide()
				-- 					-- 	end,
				-- 					-- 	desc = "Dismiss popups",
				-- 					-- },
				-- 					-- {
				-- 					-- 	"<leader>e",
				-- 					-- 	function()
				-- 					-- 		Snacks.picker.explorer()
				-- 					-- 	end,
				-- 					-- 	desc = "Explorer",
				-- },
			}
			if vim.g.picker_engine ~= "snacks" then
				return keys
			end
			--
			-- 				local picker_keys = {
			-- 					-- {
			-- 					-- 	"<leader><leader>",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.buffers()
			-- 					-- 	end,
			-- 					-- 	desc = "Buffers",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>/",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.grep()
			-- 					-- 	end,
			-- 					-- 	desc = "Grep",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>:",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.command_history()
			-- 					-- 	end,
			-- 					-- 	desc = "Command History",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sf",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.files()
			-- 					-- 	end,
			-- 					-- 	desc = "Find Files",
			-- 					-- },
			-- 					-- -- find
			-- 					-- {
			-- 					-- 	"<leader>sB",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.pickers()
			-- 					-- 	end,
			-- 					-- 	desc = "Pickers",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sgf",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.git_files()
			-- 					-- 	end,
			-- 					-- 	desc = "Find Git Files",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>s.",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.recent()
			-- 					-- 	end,
			-- 					-- 	desc = "Recent",
			-- 					-- },
			-- 					-- -- git
			-- 					-- {
			-- 					-- 	"<leader>sgc",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.git_log()
			-- 					-- 	end,
			-- 					-- 	desc = "Git Log",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sgl",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.git_log()
			-- 					-- 	end,
			-- 					-- 	desc = "Git Log",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sgs",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.git_status()
			-- 					-- 	end,
			-- 					-- 	desc = "Git Status",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sgb",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.git_branches()
			-- 					-- 	end,
			-- 					-- 	desc = "Git Branches",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sgz",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.git_stash()
			-- 					-- 	end,
			-- 					-- 	desc = "Git Stash",
			-- 					-- },
			-- 					-- -- Grep
			-- 					-- {
			-- 					-- 	"<leader>sz",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.lines()
			-- 					-- 	end,
			-- 					-- 	desc = "Fuzzy find in buffer",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sb",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.grep_buffers()
			-- 					-- 	end,
			-- 					-- 	desc = "Grep Open Buffers",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sw",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.grep_word()
			-- 					-- 	end,
			-- 					-- 	desc = "Visual selection or word",
			-- 					-- 	mode = { "n", "x" },
			-- 					-- },
			-- 					-- -- search
			-- 					-- {
			-- 					-- 	'<leader>s"',
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.registers()
			-- 					-- 	end,
			-- 					-- 	desc = "Registers",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sa",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.autocmds()
			-- 					-- 	end,
			-- 					-- 	desc = "Autocmds",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sc",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.command_history()
			-- 					-- 	end,
			-- 					-- 	desc = "Command History",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sv",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.commands()
			-- 					-- 	end,
			-- 					-- 	desc = "Commands",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sd",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.diagnostics()
			-- 					-- 	end,
			-- 					-- 	desc = "Diagnostics",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sh",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.help()
			-- 					-- 	end,
			-- 					-- 	desc = "Help Pages",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sH",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.highlights()
			-- 					-- 	end,
			-- 					-- 	desc = "Highlights",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sj",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.jumps()
			-- 					-- 	end,
			-- 					-- 	desc = "Jumps",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sk",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.keymaps()
			-- 					-- 	end,
			-- 					-- 	desc = "Keymaps",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sl",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.loclist()
			-- 					-- 	end,
			-- 					-- 	desc = "Location List",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sM",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.man()
			-- 					-- 	end,
			-- 					-- 	desc = "Man Pages",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sm",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.marks()
			-- 					-- 	end,
			-- 					-- 	desc = "Marks",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>s'",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.marks()
			-- 					-- 	end,
			-- 					-- 	desc = "Marks",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sr",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.resume()
			-- 					-- 	end,
			-- 					-- 	desc = "Resume",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>.",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.resume()
			-- 					-- 	end,
			-- 					-- 	desc = "Resume",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sq",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.qflist()
			-- 					-- 	end,
			-- 					-- 	desc = "Quickfix List",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sC",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.colorschemes()
			-- 					-- 	end,
			-- 					-- 	desc = "Colorschemes",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>su",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.undo()
			-- 					-- 	end,
			-- 					-- 	desc = "Undo",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>qp",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.projects()
			-- 					-- 	end,
			-- 					-- 	desc = "Projects",
			-- 					-- },
			-- 					-- -- LSP
			-- 					-- {
			-- 					-- 	"gd",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.lsp_definitions()
			-- 					-- 	end,
			-- 					-- 	desc = "Goto Definition",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"gr",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.lsp_references()
			-- 					-- 	end,
			-- 					-- 	nowait = true,
			-- 					-- 	desc = "References",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"gI",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.lsp_implementations()
			-- 					-- 	end,
			-- 					-- 	desc = "Goto Implementation",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"gy",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.lsp_type_definitions()
			-- 					-- 	end,
			-- 					-- 	desc = "Goto T[y]pe Definition",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>ss",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.lsp_symbols()
			-- 					-- 	end,
			-- 					-- 	desc = "LSP Symbols",
			-- 					-- },
			-- 					-- {
			-- 					-- 	"<leader>sS",
			-- 					-- 	function()
			-- 					-- 		Snacks.picker.lsp_workspace_symbols()
			-- 					-- 	end,
			-- 					-- 	desc = "LSP Workspace Symbols",
			-- 					-- },
			--
			-- 					-- Notifications
			-- 					{
			-- 						"<leader>sP",
			-- 						function()
			-- 							Snacks.picker.notifications()
			-- 						end,
			-- 						desc = "Search notifs",
			-- 					},
			-- 				}
			--
			-- 				for _, entry in ipairs(picker_keys) do
			-- 					table.insert(keys, entry)
			-- 				end
			-- --
			-- 				return keys
		end,
		-- opts = {
		-- 				debug = { enabled = true },
		-- 				indent = {
		-- 					enabled = true,
		-- 					animate = { enabled = true },
		-- 				},
		-- 				input = { enabled = true },
		-- 				notifier = {
		-- 					enabled = true,
		-- 					style = "minimal",
		-- 				},
		-- 				picker = {
		-- 					enabled = vim.g.picker_engine == "snacks",
		-- 					formatters = {
		-- 						file = {
		-- 							filename_first = true, -- display filename before the file path
		-- 						},
		-- 					},
		-- 					layout = {
		-- 						cycle = true,
		-- 						--- Use the default layout or vertical if the window is too narrow
		-- 						preset = function()
		-- 							return vim.o.columns >= 120 and "telescope" or "vertical"
		-- 						end,
		-- 					},
		-- 					win = {
		-- 						-- input window
		-- 						input = {
		-- 							keys = {
		-- 								["<Esc>"] = { "close", mode = { "n", "i" } },
		-- 								["<C-_>"] = { "toggle_help", mode = { "n", "i" } },
		-- 								["<c-p>"] = { "toggle_preview", mode = { "i", "n" } },
		-- 								["<pagedown>"] = { "list_scroll_down", mode = { "i", "n" } },
		-- 								["<pageup>"] = { "list_scroll_up", mode = { "i", "n" } },
		-- 								["<a-d>"] = { "bufdelete", mode = { "i", "n" } },
		-- 							},
		-- 						},
		-- 					},
		-- 				},
		-- 				quickfile = { enabled = true },
		-- 				words = { enabled = true },
		-- 				dashboard = {
		-- 					enabled = false,
		-- 					preset = {
		-- 						header = [[
		-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
		-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
		-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
		-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
		-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
		-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
		--                                             ]]
		-- 							.. vim.version().major
		-- 							.. "."
		-- 							.. vim.version().minor
		-- 							.. "."
		-- 							.. vim.version().patch,
		-- 						keys = {
		-- 							{
		-- 								icon = " ",
		-- 								key = "f",
		-- 								desc = "Find file",
		-- 								action = ":lua Snacks.dashboard.pick('files')",
		-- 							},
		-- 							{
		-- 								icon = " ",
		-- 								key = "g",
		-- 								desc = "Find text",
		-- 								action = ":lua Snacks.dashboard.pick('live_grep')",
		-- 							},
		-- 							{ icon = " ", key = "e", desc = "New file", action = ":ene" },
		-- 							{
		-- 								icon = " ",
		-- 								key = "r",
		-- 								desc = "Recent files",
		-- 								action = ":lua Snacks.dashboard.pick('oldfiles')",
		-- 							},
		-- 							{ icon = "󰁯 ", key = "w", desc = "Restore session", action = ":SessionSearch" },
		-- 							{ icon = "󰊢 ", key = "n", desc = "Neogit", action = ":Neogit" },
		-- 							{
		-- 								icon = "󰒲 ",
		-- 								key = "l",
		-- 								desc = "Lazy",
		-- 								action = ":Lazy",
		-- 								enabled = package.loaded.lazy ~= nil,
		-- 							},
		-- 							{ icon = " ", key = "m", desc = "Mason", action = ":Mason" },
		-- 							{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
		-- 						},
		-- 					},
		-- 				},
		-- 				styles = {
		-- 					notification_history = {
		-- 						keys = { ["<esc>"] = "close" },
		-- 					},
		-- 				},
		-- 			},
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
	-- 		{
	-- 			"folke/trouble.nvim",
	-- 			optional = true,
	-- 			specs = {
	-- 				"folke/snacks.nvim",
	-- 				opts = function(_, opts)
	-- 					return vim.tbl_deep_extend("force", opts or {}, {
	-- 						picker = {
	-- 							actions = require("trouble.sources.snacks").actions,
	-- 							win = {
	-- 								input = {
	-- 									keys = {
	-- 										["<c-t>"] = { "trouble_open", mode = { "n", "i" } },
	-- 									},
	-- 								},
	-- 							},
	-- 						},
	-- 					})
	-- 				end,
	-- 			},
	-- 		},
	-- 	},
	-------------------------------------------------------------------------------------------------
	-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
	--
	-- This is often very useful to both group configuration, as well as handle
	-- lazy loading plugins that don't need to be loaded immediately at startup.
	--
	-- For example, in the following configuration, we use:
	--  event = 'VimEnter'
	--
	-- which loads which-key before all the UI elements are loaded. Events can be
	-- normal autocommands events (`:help autocmd-events`).
	--
	-- Then, because we use the `config` key, the configuration only runs
	-- after the plugin has been loaded:
	--  config = function() ... end

	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()

			-- Document existing key chains
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
	-------------------------------------------------------------------------------------------------
	{
		"ahmedkhalf/project.nvim",
		event = "VimEnter",
		config = function()
			require("project_nvim").setup({
				-- Manual mode doesn't automatically change your root directory, so you have
				-- the option to manually do so using `:ProjectRoot` command.
				manual_mode = true,

				-- Methods of detecting the root directory. **"lsp"** uses the native neovim
				-- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
				-- order matters: if one is not detected, the other is used as fallback. You
				-- can also delete or rearangne the detection methods.
				detection_methods = { "lsp", "pattern" },

				-- All the patterns used to detect root dir, when **"pattern"** is in
				-- detection_methods
				patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },

				-- Table of lsp clients to ignore by name
				-- eg: { "efm", ... }
				ignore_lsp = {},

				-- Don't calculate root dir on specific directories
				-- Ex: { "~/.cargo/*", ... }
				exclude_dirs = {},

				-- Show hidden files in telescope
				show_hidden = false,

				-- When set to false, you will get a message when project.nvim changes your
				-- directory.
				silent_chdir = true,

				-- What scope to change the directory, valid options are
				-- * global (default)
				-- * tab
				-- * win
				scope_chdir = "global",

				-- Path where project.nvim will store the project history for use in
				-- telescope
				datapath = vim.fn.stdpath("data"),
			})
		end,
	},
	-------------------------------------------------------------------------------------------------
	-- NOTE: Plugins can specify dependencies.
	--
	-- The dependencies are proper plugin specifications as well - anything
	-- you do for a plugin at the top level, you can do for a dependency.
	--
	-- Use the `dependencies` key to specify the dependencies of a particular plugin

	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			-- Telescope is a fuzzy finder that comes with a lot of different things that
			-- it can fuzzy find! It's more than just a "file finder", it can search
			-- many different aspects of Neovim, your workspace, LSP, and more!
			--
			-- The easiest way to use Telescope, is to start by doing something like:
			--  :Telescope help_tags
			--
			-- After running this command, a window will open up and you're able to
			-- type in the prompt window. You'll see a list of `help_tags` options and
			-- a corresponding preview of the help.
			--
			-- Two important keymaps to use while in Telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the current
			-- Telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require("telescope").setup({
				-- You can put your default mappings / updates / etc. in here
				--  All the info you're looking for is in `:help telescope.setup()`
				--
				-- defaults = {
				--   mappings = {
				--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
				--   },
				-- },
				-- pickers = {}
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
			pcall(require("telescope").load_extension, "projects")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>sb", builtin.builtin, { desc = "[S]earch [B]uiltins" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
			vim.keymap.set("n", "<leader>st", builtin.treesitter, { desc = "[S]earch [T]reesitter" })
			vim.keymap.set("n", "<leader>sls", builtin.lsp_document_symbols, { desc = "[S]earch [D]ocument [S]ymbols" })
			vim.keymap.set("n", "<leader>sp", ":Telescope projects<Return>", { desc = "[S]earch [P]rojects" })

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
	-------------------------------------------------------------------------------------------------

	-- LSP Plugins
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	-------------------------------------------------------------------------------------------------
	{ "Bilal2453/luvit-meta", lazy = true },
	-------------------------------------------------------------------------------------------------
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			-- { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			{ "mason-org/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- Allows extra capabilities provided by nvim-cmp
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- Brief aside: **What is LSP?**
			--
			-- LSP is an initialism you've probably heard, but might not understand what it is.
			--
			-- LSP stands for Language Server Protocol. It's a protocol that helps editors
			-- and language tooling communicate in a standardized fashion.
			--
			-- In general, you have a "server" which is some tool built to understand a particular
			-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
			-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
			-- processes that communicate with some "client" - in this case, Neovim!
			--
			-- LSP provides Neovim with features like:
			--  - Go to definition
			--  - Find references
			--  - Autocompletion
			--  - Symbol Search
			--  - and more!
			--
			-- Thus, Language Servers are external tools that must be installed separately from
			-- Neovim. This is where `mason` and related plugins come into play.
			--
			-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
			-- and elegantly composed help section, `:help lsp-vs-treesitter`

			--  This function gets run when an LSP attaches to a particular buffer.
			--    That is to say, every time a new file is opened that is associated with
			--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
			require("lspconfig").arduino_language_server.setup({
				cmd = {
					"arduino-language-server",
					"-cli-config",
					"~/.arduinoIDE/arduino-cli.yaml", -- Replace with the actual path
					"-fqbn",
					"arduino:avr:uno", -- Replace with your board's fully qualified board name
				},
				-- Other configuration options, such as clangd path if needed
			})
			require("lspconfig").dartls.setup({
				cmd = { "dart", "language-server", "--protocol=lsp" },
			})

			--    function will be executed to configure the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- NOTE: Remember that Lua is a real programming language, and as such it is possible
					-- to define small helper and utility functions so you don't have to repeat yourself.
					--
					-- In this case, we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-t>.
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					--map("gd", function()
					--require("telescope.builtin").lsp_definitions({ jump_type = "vsplit" })
					--end)

					-- Find references for the word under your cursor.
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("<leader>dS", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

					-- Fuzzy find all the symbols in your current workspace.
					--  Similar to document symbols, except searches over your entire project.
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					-- map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
					if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				-- clangd = {},
				-- gopls = {},
				-- pyright = {},
				-- rust_analyzer = {},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP (`tsserver`) will work just fine
				-- tsserver = {},
				--

				lua_ls = {
					-- cmd = {...},
					-- filetypes = { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			-- Ensure the servers and tools above are installed
			--  To check the current status of installed tools and/or manually install
			--  other tools, you can run
			--    :Mason
			--
			--  You can press `g?` for help in this menu.
			require("mason").setup()

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	-------------------------------------------------------------------------------------------------

	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use 'stop_after_first' to run the first available formatter from the list
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},
	-------------------------------------------------------------------------------------------------

	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
				},
			},
			"saadparwaiz1/cmp_luasnip",

			-- Adds other completion capabilities.
			--  nvim-cmp does not ship with all sources by default. They are split
			--  into multiple repos for maintenance purposes.
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({
				history = true,
				region_check_events = "InsertEnter",
				delete_check_events = "TextChanged,InsertLeave",
			})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },

				-- For an understanding of why these mappings were
				-- chosen, you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				mapping = cmp.mapping.preset.insert({
					-- Select the [n]ext item
					["<C-n>"] = cmp.mapping.select_next_item(),
					-- Select the [p]revious item
					["<C-p>"] = cmp.mapping.select_prev_item(),

					-- Scroll the documentation window [b]ack / [f]orward
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					-- Accept ([y]es) the completion.
					--  This will auto-import if your LSP supports it.
					--  This will expand snippets if the LSP sent a snippet.
					--["<C-y>"] = cmp.mapping.confirm({ select = true }),

					-- If you prefer more traditional completion keymaps,
					-- you can uncomment the following lines
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					--['<Tab>'] = cmp.mapping.select_next_item(),
					--['<S-Tab>'] = cmp.mapping.select_prev_item(),

					-- Manually trigger a completion from nvim-cmp.
					--  Generally you don't need this, because nvim-cmp will display
					--  completions whenever it has completion options available.
					["<C-Space>"] = cmp.mapping.complete({}),

					-- Think of <c-l> as moving to the right of your snippet expansion.
					--  So if you have a snippet that's like:
					--  function $name($args)
					--    $body
					--  end
					--
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),

					-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
					--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
				}),
				sources = {
					{
						name = "lazydev",
						-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
						group_index = 0,
					},
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
				},
			})
		end,
	},
	-------------------------------------------------------------------------------------------------
	{ -- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		-- init = function()
		-- 	-- Load the colorscheme here.
		-- 	-- Like many other themes, this one has different styles, and you could load
		-- 	-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
		-- 	vim.cmd.colorscheme("tokyonight-night")
		--
		-- 	-- You can configure highlights by doing something like:
		-- 	vim.cmd.hi("Comment gui=none")
		-- end,
	},
	-------------------------------------------------------------------------------------------------
	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	-------------------------------------------------------------------------------------------------
	{ -- Collection of various small independent plugins/modules
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
	-------------------------------------------------------------------------------------------------
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = { "tadmccorkle/markdown.nvim" },
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			-- indent = { enable = true, disable = { "ruby" } },
		},
		config = function(_, opts)
			-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

			---@diagnostic disable-next-line: missing-fields

			require("nvim-treesitter.configs").setup({
				opts,
				ensure_installed = { "markdown", "markdown_inline", "html" },
				markdown = { enable = true },
			})

			-- There are additional nvim-treesitter modules that you can use to interact
			-- with nvim-treesitter. You should go explore a few and see what interests you:
			--
			--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
			--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
			--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
		end,
	},
	{
		"kawre/leetcode.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			-- "ibhagwan/fzf-lua",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
		opts = {
			-- configuration goes here
		},
	},
	-------------------------------------------------------------------------------------------------
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed.
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
			"echasnovski/mini.pick", -- optional
		},
		config = true,
	},
	-------------------------------------------------------------------------------------------------
	-- {
	--   'saghen/blink.cmp',
	--   enabled = true,
	--   version = '*',
	--   dependencies = {
	--     'mikavilpas/blink-ripgrep.nvim',
	--     {
	--       'L3MON4D3/LuaSnip',
	--       version = 'v2.*',
	--       build = 'make install_jsregexp',
	--       dependencies = {
	--         'rafamadriz/friendly-snippets',
	--         config = function()
	--           require('luasnip.loaders.from_vscode').lazy_load()
	--           require('luasnip.loaders.from_vscode').lazy_load({ paths = { vim.fn.stdpath 'config' .. '/snippets' } })
	--
	--           local extends = {
	--             typescript = { 'tsdoc' },
	--             javascript = { 'jsdoc' },
	--             lua = { 'luadoc' },
	--             python = { 'pydoc' },
	--             rust = { 'rustdoc' },
	--             cs = { 'csharpdoc' },
	--             java = { 'javadoc' },
	--             c = { 'cdoc' },
	--             cpp = { 'cppdoc' },
	--             php = { 'phpdoc' },
	--             kotlin = { 'kdoc' },
	--             ruby = { 'rdoc' },
	--             sh = { 'shelldoc' },
	--           }
	--           -- friendly-snippets - enable standardized comments snippets
	--           for ft, snips in pairs(extends) do
	--             require('luasnip').filetype_extend(ft, snips)
	--           end
	--         end,
	--       },
	--       opts = { history = true, delete_check_events = 'TextChanged' },
	--     },
	--   },
	--   ---@module 'blink.cmp'
	--   ---@type blink.cmp.Config
	--   opts = {
	--     snippets = { preset = 'luasnip' },
	--     keymap = { preset = 'enter' },
	--     fuzzy = { implementation = "lua" },
	--     sources = {
	--       default = {
	--         'lsp',
	--         'path',
	--         'buffer',
	--         'snippets',
	--         'ripgrep',
	--       },
	--       providers = {
	--         ripgrep = {
	--           module = 'blink-ripgrep',
	--           name = 'Ripgrep',
	--           ---@module "blink-ripgrep"
	--           ---@type blink-ripgrep.Options
	--           opts = {
	--             prefix_min_len = 4,
	--             score_offset = 10, -- should be lower priority
	--             max_filesize = '300K',
	--             search_casing = '--smart-case',
	--           },
	--         },
	--      }
	--     }
	--    }
	-- },
	-- {
	-- 	"saghen/blink.cmp",
	-- 	-- optional: provides snippets for the snippet source
	-- 	dependencies = { "rafamadriz/friendly-snippets" },
	--
	-- 	-- use a release tag to download pre-built binaries
	-- 	version = "1.*",
	-- 	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- 	-- build = 'cargo build --release',
	-- 	-- If you use nix, you can build from source using latest nightly rust with:
	-- 	-- build = 'nix run .#build-plugin',
	--
	-- 	---@module 'blink.cmp'
	-- 	---@type blink.cmp.Config
	-- 	opts = {
	-- 		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
	-- 		-- 'super-tab' for mappings similar to vscode (tab to accept)
	-- 		-- 'enter' for enter to accept
	-- 		-- 'none' for no mappings
	-- 		--
	-- 		-- All presets have the following mappings:
	-- 		-- C-space: Open menu or open docs if already open
	-- 		-- C-n/C-p or Up/Down: Select next/previous item
	-- 		-- C-e: Hide menu
	-- 		-- C-k: Toggle signature help (if signature.enabled = true)
	-- 		--
	-- 		-- See :h blink-cmp-config-keymap for defining your own keymap
	-- 		keymap = { preset = "enter" },
	--
	-- 		appearance = {
	-- 			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
	-- 			-- Adjusts spacing to ensure icons are aligned
	-- 			nerd_font_variant = "mono",
	-- 		},
	--
	-- 		-- (Default) Only show the documentation popup when manually triggered
	-- 		completion = { documentation = { auto_show = false } },
	--
	-- 		-- Default list of enabled providers defined so that you can extend it
	-- 		-- elsewhere in your config, without redefining it, due to `opts_extend`
	-- 		sources = {
	-- 			default = { "lsp", "path", "snippets", "buffer" },
	-- 		},
	--
	-- 		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
	-- 		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
	-- 		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
	-- 		--
	-- 		-- See the fuzzy documentation for more information
	-- 		fuzzy = { implementation = "lua" },
	-- 	},
	-- 	opts_extend = { "sources.default" },
	-- },
	-------------------------------------------------------------------------------------------------
	{
		"saghen/blink.nvim",
		build = "cargo build --release", -- for delimiters
		keys = {
			-- chartoggle
			{
				"<C-;>",
				function()
					require("blink.chartoggle").toggle_char_eol(";")
				end,
				mode = { "n", "v" },
				desc = "Toggle ; at eol",
			},
			{
				",",
				function()
					require("blink.chartoggle").toggle_char_eol(",")
				end,
				mode = { "n", "v" },
				desc = "Toggle , at eol",
			},

			-- tree
			-- { "<C-e>", "<cmd>BlinkTree reveal<cr>", desc = "Reveal current file in tree" },
			-- { "<leader>E", "<cmd>BlinkTree toggle<cr>", desc = "Reveal current file in tree" },
			-- { "<leader>e", "<cmd>BlinkTree toggle-focus<cr>", desc = "Toggle file tree focus" },
		},
		lazy = false,
		opts = {
			chartoggle = { enabled = true },
			indent = { enabled = false },
			tree = { enabled = true },
		},
		-- {
		-- 	"vidocqh/auto-indent.nvim",
		-- 	opts = {},
		-- },
	},
	-------------------------------------------------------------------------------------------------
	{
		"rose-pine/neovim",
		name = "rose-pine",
		-- config = function()
		-- 	vim.cmd("colorscheme rose-pine")
		-- end,
	},
	-------------------------------------------------------------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				multiwindow = false, -- Enable multiwindow support.
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 20, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
		end,
	},
	-------------------------------------------------------------------------------------------------
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		  -- stylua: ignore
		  keys = {
		    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
		    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
		    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
		    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
		    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		  },
	},
	-------------------------------------------------------------------------------------------------
	{
		"hamidi-dev/org-list.nvim",
		dependencies = {
			"tpope/vim-repeat", -- for repeatable actions with '.'
		},
		config = function()
			require("org-list").setup({
				mapping = {
					key = "<leader>lst", -- nvim-orgmode users: you might want to change this to <leader>olt
					desc = "Toggle: Cycle through list types",
				},
				checkbox_toggle = {
					enabled = true,
					key = "<C-A-Space>", -- Change the checkbox toggle key
					desc = "Toggle checkbox state",
					filetypes = { "org", "markdown" }, -- Add more filetypes as needed
				},
			})
		end,
	},
	-------------------------------------------------------------------------------------------------
	-- Using lazy.nvim
	{
		"metalelf0/black-metal-theme-neovim",
		lazy = false,
		priority = 1000,
		config = function()
			require("black-metal").setup({
				-----MAIN OPTIONS-----
				--
				-- Can be one of: bathory | burzum | dark-funeral | darkthrone | emperor | gorgoroth | immortal | impaled-nazarene | khold | marduk | mayhem | nile | taake | thyrfing | venom | windir
				theme = "bathory",
				-- Can be one of: 'light' | 'dark', or set via vim.o.background
				variant = "dark",
				-- Use an alternate, lighter bg
				alt_bg = false,
				-- If true, docstrings will be highlighted like strings, otherwise they will be
				-- highlighted like comments. Note, behavior is dependent on the language server.
				colored_docstrings = true,
				-- If true, highlights the {sign,fold} column the same as cursorline
				cursorline_gutter = true,
				-- If true, highlights the gutter darker than the bg
				dark_gutter = false,
				-- if true favor treesitter highlights over semantic highlights
				favor_treesitter_hl = false,
				-- Don't set background of floating windows. Recommended for when using floating
				-- windows with borders.
				plain_float = false,
				-- Show the end-of-buffer character
				show_eob = true,
				-- If true, enable the vim terminal colors
				term_colors = true,
				-- Keymap (in normal mode) to toggle between light and dark variants.
				toggle_variant_key = nil,
				-- Don't set background
				transparent = false,

				-----DIAGNOSTICS and CODE STYLE-----
				--
				diagnostics = {
					darker = true, -- Darker colors for diagnostic
					undercurl = true, -- Use undercurl for diagnostics
					background = true, -- Use background color for virtual text
				},
				-- The following table accepts values the same as the `gui` option for normal
				-- highlights. For example, `bold`, `italic`, `underline`, `none`.
				code_style = {
					comments = "italic",
					conditionals = "none",
					functions = "none",
					keywords = "none",
					headings = "bold", -- Markdown headings
					operators = "none",
					keyword_return = "none",
					strings = "none",
					variables = "none",
				},

				-----PLUGINS-----
				--
				-- The following options allow for more control over some plugin appearances.
				plugin = {
					lualine = {
						-- Bold lualine_a sections
						bold = true,
						-- Don't set section/component backgrounds. Recommended to not set
						-- section/component separators.
						plain = false,
					},
					cmp = { -- works for nvim.cmp and blink.nvim
						-- Don't highlight lsp-kind items. Only the current selection will be highlighted.
						plain = false,
						-- Reverse lsp-kind items' highlights in blink/cmp menu.
						reverse = false,
					},
				},

				-- CUSTOM HIGHLIGHTS --
				--
				-- Override default colors
				-- colors = {},
				-- Override highlight groups
				-- highlights = {},
			})
			-- Convenience function that simply calls `:colorscheme <theme>` with the theme
			-- specified in your config.
			-- require("black-metal").load()
		end,
	},
	-------------------------------------------------------------------------------------------------
	-- install with yarn or npm
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	-------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
