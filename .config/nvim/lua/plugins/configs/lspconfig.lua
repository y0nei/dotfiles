local M = {}
local lspconfig = require("lspconfig")

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
-- Enable (broadcasting) snippet capability for completion
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.lua_ls.setup {
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
lspconfig.pyright.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
}
-- pnpm add -g vscode-langservers-extracted
lspconfig.html.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
}
-- pnpm add -g vscode-langservers-extracted
lspconfig.cssls.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
}
-- pnpm install -g @astrojs/language-server
-- pnpm install -D prettier prettier-plugin-astro
lspconfig.astro.setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    root_dir = lspconfig.util.root_pattern("astro.config.mjs")
}
-- pnpm install -g typescript typescript-language-server
lspconfig.tsserver.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,
})

-- efm related settings --------------------------------------------------------

local languages = require("efmls-configs.defaults").languages()
local efmls_config = {
    filetypes = vim.tbl_keys(languages),
    settings = {
        rootMarkers = { ".git/" },
        languages = languages,
    },
    init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
    },
}

lspconfig.efm.setup(vim.tbl_extend("force", efmls_config, {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
    -- Custom languages, or override existing ones
    html = {
        require('efmls-configs.formatters.prettier'),
    },
}))

return M
