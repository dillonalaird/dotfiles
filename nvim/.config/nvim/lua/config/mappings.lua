vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.api.nvim_create_user_command("Format", "lua require('conform').format()", { nargs = 0 })
vim.keymap.set("n", "<leader>fm", ":Format<CR>")

vim.keymap.set("n", "<leader>p", 'O__import__("ipdb").set_trace()', { noremap = true, silent = true })

-- Commands to remember
-- vi" selects everything in quotes, vi( selects everything in parens
-- visual select, hit :s/old/new/gc to replace all with confirmation
-- visual select, hit :%s/old/new/gc to replace all with confirmation for all text
-- visual select, "+y (so shift '=), copies to clipboard
