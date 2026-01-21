-- Numbers & Indent
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- Scrolling
vim.keymap.set("n", "<C-Up>", "<C-y>")
vim.keymap.set("n", "<C-Down>", "<C-e>")
vim.keymap.set("n", "<C-k>", "<C-y>")
vim.keymap.set("n", "<C-j>", "<C-e>")

-- Langmap (Russian -> English)
vim.opt.langmap =
  "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ," ..
  "фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"

-- Leader
vim.g.mapleader = ";"

-- Clipboard
vim.keymap.set({"n","v"}, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>yy", '"+yy')
vim.keymap.set({"n","v"}, "<leader>d", '"+d')
vim.keymap.set("n", "<leader>dd", '"+dd')
vim.keymap.set({"n","v"}, "<leader>p", '"+p')
vim.keymap.set({"n","v"}, "<leader>P", '"+P')

-- Colors & Transparency
vim.opt.termguicolors = true
vim.cmd [[
  hi Normal guibg=none ctermbg=none
]]

--- LSP ---
local config = {
	on_attach = function(client, bufnr)
		local opts = { buffer = bufnr, noremap = true, silent = true }
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', ';rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({'n', 'v'}, ';ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
		vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
		vim.keymap.set('n', ';e', vim.diagnostic.open_float, opts)
		vim.keymap.set('n', ';q', vim.diagnostic.setloclist, opts)
		vim.keymap.set({'n', 'v'}, ';f', vim.lsp.buf.format, opts)
		vim.keymap.set('n', ';q', vim.diagnostic.setloclist, opts)
		vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	end,
	cmd = { 'clangd' },
}
vim.lsp.config('clangd', config)
vim.lsp.enable('clangd')

-- Autocompletion ---
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess:append('c') -- Shorter messages for better UX

-- Use Ctrl+P/N for completion navigation
vim.api.nvim_set_keymap('i', '<C-p>', '<C-x><C-o>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-n>', '<C-x><C-o>', { noremap = true, silent = true })
