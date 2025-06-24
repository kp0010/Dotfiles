---@diagnostic disable: param-type-mismatch
return {
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")

			local header = {
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
				dashboard.button("p", "   Find Project", ":Telescope projects<CR>"),
				dashboard.button("f", "󰱽   Find File", ":Telescope find_files previewer=true<CR>"),
				dashboard.button("l", "   Leetcode", ":Leet<CR>"),
				dashboard.button("r", "   Recent", ":Telescope oldfiles<CR>"),
				dashboard.button("n", "   Config", function()
					require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
				end),
				dashboard.button("z", "󰒲   Lazy", ":Lazy<CR>"),
				dashboard.button("m", "󱌣   Mason", ":Mason<CR>"),
				dashboard.button("q", "   Quit NVIM", ":qa<CR>"),
			}

			-- set highlight groups
			vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#C34043" })
			dashboard.section.header.opts.hl = "DashboardHeader"

			vim.api.nvim_set_hl(0, "DashboardFooterNormal", { fg = "#ffffff" }) -- White (default)
			vim.api.nvim_set_hl(0, "DashboardFooterOrange", { fg = "#ffa533" }) -- Orange for > 50ms
			vim.api.nvim_set_hl(0, "DashboardFooterRed", { fg = "#F9534F" }) -- Red for > 60ms

			vim.api.nvim_set_hl(0, "DashboardButtonKey", { fg = "#ffffff", bold = true }) -- Key color
			vim.api.nvim_set_hl(0, "DashboardButtonText", { fg = "#ffffff", bold = true }) -- text color

			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl_shortcut = "DashboardButtonKey"
				button.opts.hl = "DashboardButtonText"
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
}
