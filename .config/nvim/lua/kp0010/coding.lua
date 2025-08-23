return {
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	"windwp/nvim-ts-autotag",
	"smjonas/inc-rename.nvim",
	"numToStr/Comment.nvim",
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
		},
		lazy = false,
		opts = {
			chartoggle = { enabled = true },
			indent = { enabled = false },
			tree = { enabled = false },
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"chrisgrieser/nvim-spider",
		keys = {
			{ "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
			{ "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
			{ "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
		},
	},
	{
		"stevearc/oil.nvim",
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
				use_default_keymaps = false,
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
			})
		end,
	},
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

			local harpoon = require("harpoon")

			harpoon:setup()

			vim.keymap.set({ "n", "v" }, "<leader>a", function()
				harpoon:list():add()
			end)
			vim.keymap.set({ "n", "v", "i" }, "<A-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			vim.keymap.set({ "n", "v", "i" }, "<A-f>", function()
				harpoon:list():select(1)
			end)
			vim.keymap.set({ "n", "v", "i" }, "<A-d>", function()
				harpoon:list():select(2)
			end)
			vim.keymap.set({ "n", "v", "i" }, "<A-s>", function()
				harpoon:list():select(3)
			end)
			vim.keymap.set({ "n", "v", "i" }, "<A-a>", function()
				harpoon:list():select(4)
			end)

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set({ "n", "v", "i" }, "<A-i>", function()
				harpoon:list():prev()
			end)
			vim.keymap.set({ "n", "v", "i" }, "<A-o>", function()
				harpoon:list():next()
			end)
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		-- stylua: ignore
		keys = {
			{ "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
			{ "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
	
			{ "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
		},
	},
	{
		"hamidi-dev/org-list.nvim",
		dependencies = {
			"tpope/vim-repeat", -- for repeatable actions with '.'
		},
		config = function()
			require("org-list").setup({
				mapping = {
					key = "<leader>li", -- nvim-orgmode users: you might want to change this to <leader>olt
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
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
}
