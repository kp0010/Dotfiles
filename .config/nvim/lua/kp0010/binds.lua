-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<leader>nh", "<cmd>nohlsearch<CR>")
-----------------------------------------------------------------------

-- jk to ESC
vim.keymap.set("i", "jk", "<Esc>")
-----------------------------------------------------------------------

-- vs to VSPLIT
vim.keymap.set("n", "<leader>vs", ":vsplit<Return>")
-----------------------------------------------------------------------

-- Ctrl-Alt-J/K to increase/decrease window size
vim.keymap.set("n", "<C-A-j>", "<C-w><")
vim.keymap.set("n", "<C-A-k>", "<C-w>>")
-----------------------------------------------------------------------

-- Map x to not copy cut letter
vim.keymap.set("n", "x", '"_x')
-----------------------------------------------------------------------

-- Copy to Clipboard
vim.keymap.set({ "v", "n" }, "<leader>y", '"+y')
vim.keymap.set({ "v", "n" }, "<leader>Y", '"+yg_')
vim.keymap.set("n", "<leader>yy", '"+yyg_')
vim.keymap.set("n", "<leader>yy", '"+yyg_')
vim.keymap.set("n", "<leader>gy", "mzgg\"+yG'z")
-----------------------------------------------------------------------

-- Paste from Clipboard
vim.keymap.set({ "v", "n" }, "<leader>p", '"+p')
vim.keymap.set({ "v", "n" }, "<leader>P", '"+P')
-----------------------------------------------------------------------

-- Delete to Clipboard and Delete without overwrite
vim.keymap.set({ "v", "n" }, "<leader>d", '"+d')
vim.keymap.set({ "v", "n" }, "<leader>D", '"+D')
vim.keymap.set("x", "<leader>pd", '"_dP')
-----------------------------------------------------------------------

-- Noice dismiss and disable
-- vim.keymap.set({ "v", "n" }, "<leader>jj", ":NoiceDismiss<Return>")
-- vim.keymap.set({ "v", "n" }, "<leader>jd", ":NoiceDisable<Return>")
-----------------------------------------------------------------------

-- Dashboard
vim.keymap.set("n", "<leader>ds", ":Alpha<Return>")
-----------------------------------------------------------------------

-- Spider
vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
-----------------------------------------------------------------------

-- Add new line below (Leader-o)
vim.keymap.set(
	"n",
	"<leader>o",
	':<C-u>call append(line("."),   repeat([""], v:count1))<Return>',
	{ noremap = true, silent = true }
)
-----------------------------------------------------------------------

-- Save and Quit
vim.keymap.set("n", "<leader>w", ":update<Return>")
vim.keymap.set("n", "<leader>wq", ":wq<Return>")
vim.keymap.set("n", "<leader>q", ":quit<Return>")
-----------------------------------------------------------------------

-- Rename and Edit Name
vim.keymap.set("n", "<leader>cn", ":IncRename ")
vim.keymap.set("n", "<leader>rn", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })
-----------------------------------------------------------------------

-- Comment
vim.keymap.set("n", "<C-_>", function()
	require("Comment.api").toggle.linewise.current()
end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-/>", function()
	require("Comment.api").toggle.linewise.current()
end, { noremap = true, silent = true })
-----------------------------------------------------------------------

-- Diagnostic keymap
vim.keymap.set("n", "<leader>Q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
-----------------------------------------------------------------------

-- Exit terminal mode in the builtin terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-----------------------------------------------------------------------

-- Disable arrow keys in normal mode
-- vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')
-----------------------------------------------------------------------

-- CTRL+<hjkl> to switch between windows
vim.keymap.set({ "n", "v", "i" }, "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set({ "n", "v", "i" }, "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set({ "n", "v", "i" }, "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set({ "n", "v", "i" }, "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-----------------------------------------------------------------------

-- UndoTree Toggle
vim.keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle, { desc = "[U]ndo [T]ree Toggle" })
-----------------------------------------------------------------------

-- Tab Shortcuts
vim.keymap.set("n", "<C-Tab>", ":tabn<Return>")
vim.keymap.set("n", "<C-S-Tab>", ":tabp<Return>")
vim.keymap.set("n", "<leader>nt", ":$tabnew<Return>")
vim.keymap.set("n", "<leader>rt", ":tabclose<Return>")
-----------------------------------------------------------------------

-- Neotree Sidebar
vim.keymap.set("n", "<A-1>", ":Neotree position=right toggle<Return>")
vim.keymap.set("n", "<A-2>", ":Neotree position=right reveal<Return>")
-----------------------------------------------------------------------

-- C-/ to Comment
-- vim.keymap.set({ "v", "n" }, "<C-/>", "gcc")
-----------------------------------------------------------------------

-- Leader - to Oil File Manager
vim.keymap.set("n", "<leader>-", ":Oil<Return>")
-----------------------------------------------------------------------

-- TD to TODOs
vim.keymap.set({ "n", "v" }, "<leader>td", ":TodoTelescope<Return>")
-----------------------------------------------------------------------

-- Stay in Indent Mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
-----------------------------------------------------------------------

vim.keymap.set("n", "[c", function()
	require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })

-----------------------------------------------------------------------
-- Leet Keybinds

vim.keymap.set("n", "<leader>lt", ":Leet<Return>")
vim.keymap.set("n", "<leader>lb", ":Leet<Return>")
vim.keymap.set("n", "<leader>lf", ":Leet submit<Return>")
vim.keymap.set("n", "<leader>lr", ":Leet test<Return>")
vim.keymap.set("n", "<leader>ll", ":Leet lang<Return>")
vim.keymap.set("n", "<leader>lls", ":Leet last_submit<Return>")
-----------------------------------------------------------------------
-- Moving While in Visual Mode

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv")
-----------------------------------------------------------------------
-- Join but without Moving Cursor

vim.keymap.set("n", "J", "mzJ'z")
-----------------------------------------------------------------------
-- Move with C-D and C-U with cursor in center

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-----------------------------------------------------------------------
-- Move with n and N with cursor in center

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-----------------------------------------------------------------------
-- Toggle Wrap and Linebreak

-- vim.keymap.set("n", "<leader>vw", ":set wrap!<Return>")
vim.keymap.set("n", "<leader>vl", ":set linebreak!<Return>")
