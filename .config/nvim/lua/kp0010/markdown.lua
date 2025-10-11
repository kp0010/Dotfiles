return {
	-- {
	-- 	"OXY2DEV/markview.nvim",
	-- 	lazy = false,
	--
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- 	config = function()
	-- 		require("markview").setup({
	-- 			latex = {
	-- 				enable = true,
	--
	-- 				paranthesis = {
	-- 					enable = true,
	-- 					hl = "@punctuation.paranthesis",
	-- 				},
	-- 				blocks = {
	-- 					enable = true,
	-- 					hl = "Code",
	-- 					text = { " LaTeX ", "Special" },
	-- 				},
	-- 				inlines = {
	-- 					enable = true,
	-- 				},
	-- 				experimental = {
	-- 					check_rtp = false,
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
	-------------------------------------------------------------------------------------------------
	{
		"iamcco/markdown-preview.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	-------------------------------------------------------------------------------------------------
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
		opts = {
			latex = {
				render_modes = true,
			},
		},
	},
	-------------------------------------------------------------------------------------------------
	{
		"hat0uma/csvview.nvim",
		---@module "csvview"
		---@type CsvView.Options
		opts = {
			view = {
				display_mode = "border",
			},
			-- Default configuration with auto-detection
			{
				parser = {
					delimiter = {
						ft = {
							csv = ",", -- Always use comma for .csv files
							tsv = "\t", -- Always use tab for .tsv files
						},
						fallbacks = { -- Try these delimiters in order for other files
							",", -- Comma (most common)
							"\t", -- Tab
							";", -- Semicolon
							"|", -- Pipe
							":", -- Colon
							" ", -- Space
						},
					},
				},
			},
			keymaps = {
				-- Text objects for selecting fields
				textobject_field_inner = { "if", mode = { "o", "x" } },
				textobject_field_outer = { "af", mode = { "o", "x" } },
				-- Excel-like navigation:
				-- Use <Tab> and <S-Tab> to move horizontally between fields.
				-- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
				-- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
				jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
				jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
				jump_next_row = { "<Enter>", mode = { "n", "v" } },
				jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
			},
		},
		cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
	},
	-------------------------------------------------------------------------------------------------
}
