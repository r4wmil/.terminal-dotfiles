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
vim.opt.modeline = false
vim.api.nvim_create_user_command("LspOn", function()
  vim.lsp.enable("clangd")
end, { desc = "Enable & attach clangd LSP" })

vim.lsp.config("clangd", {
  cmd = { "clangd", "--background-index", "--clang-tidy" },  -- add flags you like
  root_markers = {
    ".clangd",
    "compile_commands.json",
    "compile_flags.txt",
    "build/compile_commands.json",   -- common CMake path
  },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  capabilities = vim.lsp.protocol.make_client_capabilities(), -- or your cmp capabilities
})

-- Optional: very basic keymaps (only active after LspOn + attachment)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
    end

    map("gd", vim.lsp.buf.definition,       "Go to definition")
    map("gD", vim.lsp.buf.declaration,      "Go to declaration")
    map("gi", vim.lsp.buf.implementation,   "Go to implementation")
    map("gr", vim.lsp.buf.references,       "List references")
    map("gy", vim.lsp.buf.type_definition,  "Go to type definition")
    map("<leader>rn", vim.lsp.buf.rename,   "Rename symbol")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("K",  vim.lsp.buf.hover,            "Hover documentation")
  end,
})
