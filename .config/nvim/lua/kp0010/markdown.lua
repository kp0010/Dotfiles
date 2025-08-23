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
}
