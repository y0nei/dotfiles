local M = {}

-- Change default diagnostic symbols
local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, {
        texthl = sign.name,
        text = sign.text,
        numhl = ""
    })
end

-- On language server attach to buffer
M.on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    local keymap = vim.keymap.set

    -- TODO: Figure out how to import those keybinds from somewhere else
    keymap("n", "gD", vim.lsp.buf.declaration, opts)
    keymap("n", "gd", vim.lsp.buf.definition, opts)
    keymap("n", "gi", vim.lsp.buf.implementation, opts)
    keymap("n", "K", vim.lsp.buf.hover, opts)
    keymap("n", "<C-h>", vim.lsp.buf.signature_help, opts)
    keymap("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
    keymap("n", "gr", function()
        require("telescope.builtin").lsp_references()
    end, opts)
    keymap("n", "<leader>f", function()
        vim.lsp.buf.format { async = true }
    end, opts)

    -- Use LSP as a provider for illuminate if available
    local ok, illuminate = pcall(require, "illuminate")
    if not ok then
        return
    else
        illuminate.on_attach(client)
    end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

require("lspconfig").lua_ls.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,

    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                maxPreload = 100000,
                preloadFileSize = 10000
            }
        }
    }
}
require("lspconfig").pyright.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
}
require("lspconfig").html.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
}

-- Enable (broadcasting) snippet capability for completion
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
require("lspconfig").cssls.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
}

return M
