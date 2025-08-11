return {
	"sainnhe/gruvbox-material",
	"shaunsingh/nord.nvim",
	"navarasu/onedark.nvim",
	"ficcdaf/ashen.nvim",
	"rebelot/kanagawa.nvim",
	"projekt0n/github-nvim-theme",
	"folke/tokyonight.nvim",
	"nyoom-engineering/oxocarbon.nvim",

	{
		"metalelf0/black-metal-theme-neovim",
		lazy = false,
		priority = 1000,
		config = function()
			require("black-metal").setup({
				-- bathory | burzum | dark-funeral | darkthrone | emperor | venom | impaled-nazarene
				-- nile | khold | marduk | mayhem | immortal | taake | thyrfing | gorgoroth | windir
				theme = "bathory",
				-- 'light' | 'dark', or set via vim.o.background
				variant = "dark",
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				styles = {
					italic = false,
				},
			})

			color = color or "rose-pine-moon"

			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		end,
	},
}
