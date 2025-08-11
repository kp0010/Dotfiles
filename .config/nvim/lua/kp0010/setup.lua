-- Set the Theme
vim.cmd([[
	try
		" colorscheme gruvbox-material
		" colorscheme ashen
		" colorscheme kanagawa-dragon
		colorscheme rose-pine-moon
	catch /^Vim\%((\a\+)\)\=:E185/
		colorscheme default
	endtry
]])

-----------------------------------------------------------------------

-- Set spacing to 0 on VimEnter
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.fn.system("kitty @ set-spacing padding=0")
	end,
})

-- Reset spacing to default on VimLeave
vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		vim.fn.system("kitty @ set-spacing padding=default")
	end,
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-----------------------------------------------------------------------
-- [[ Setting options ]]

-- Have Nerd Font Yes Bruh
vim.g.have_nerd_font = true
-----------------------------------------------------------------------

-- Terminal
vim.opt.shell = "/bin/zsh"
-----------------------------------------------------------------------

-- vim.diagnostic.config({ virtual_lines = true })
vim.diagnostic.config({ virtual_text = true })
-----------------------------------------------------------------------

vim.opt.guifont = { "JetBrainsMono Nerd Font", ":h11" }
-----------------------------------------------------------------------

-- Tab width
vim.opt.shiftwidth = 4
-----------------------------------------------------------------------

-- Search Opts
vim.opt.hlsearch = false
vim.opt.incsearch = true
-----------------------------------------------------------------------

-- Search Opts
vim.opt.termguicolors = true
-----------------------------------------------------------------------

-- Make line numbers default
vim.opt.number = true
-----------------------------------------------------------------------

-- You can also add relative line numbers, to help with jumping.
vim.opt.relativenumber = true
-----------------------------------------------------------------------

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"
-----------------------------------------------------------------------

-- Copies Indent from current line to the new one
vim.opt.autoindent = false
vim.opt.smartindent = true
-----------------------------------------------------------------------

-- Case-Insesitive Search unless /C or Uppercase in search
vim.opt.ignorecase = true
-----------------------------------------------------------------------

vim.opt.smartcase = true
-----------------------------------------------------------------------

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = true
-----------------------------------------------------------------------

vim.opt.signcolumn = "yes"
-----------------------------------------------------------------------

-- Decrease update time
vim.opt.updatetime = 250
-----------------------------------------------------------------------

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 200
-----------------------------------------------------------------------

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
-----------------------------------------------------------------------

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = false
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-----------------------------------------------------------------------

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"
-----------------------------------------------------------------------

-- Show which line your cursor is on
vim.opt.cursorline = true
-----------------------------------------------------------------------

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 8
-----------------------------------------------------------------------

-- Color line number to Display Errors and Warns
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
		numhl = {
			[vim.diagnostic.severity.WARN] = "WarningMsg",
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticHint",
		},
	},
})

-----------------------------------------------------------------------

vim.g.indentscope_disable = true
