-- KP0010 Neovim Config

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
end
vim.opt.rtp:prepend(lazypath)
-----------------------------------------------------------------------

-- [[ Configure and install plugins ]]

require("lazy").setup({
	{ import = "kp0010.ui" },
	{ import = "kp0010.markdown" },
	{ import = "kp0010.lsp" },
	{ import = "kp0010.telescope" },
	{ import = "kp0010.dashboard" },
	{ import = "kp0010.coding" },
	{ import = "kp0010.git" },
	{ import = "kp0010.other" },
	{ import = "kp0010.themes" },
})

-----------------------------------------------------------------------
require("kp0010.setup")
require("kp0010.binds")
