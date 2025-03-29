-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
-----------------------------------------------------------------------

-- Terminal
vim.opt.shell = "/bin/zsh"
-----------------------------------------------------------------------

-- [[ Setting options ]]

vim.opt.guifont = { "JetBrainsMono Nerd Font", ":h11" }
-----------------------------------------------------------------------

-- Tab width
vim.opt.shiftwidth = 4
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
vim.opt.timeoutlen = 300
-----------------------------------------------------------------------

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
-----------------------------------------------------------------------

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-----------------------------------------------------------------------

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"
-----------------------------------------------------------------------

-- Show which line your cursor is on
vim.opt.cursorline = true
-----------------------------------------------------------------------

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 15
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
