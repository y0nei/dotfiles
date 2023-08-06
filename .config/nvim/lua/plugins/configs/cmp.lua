local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return "cmp failed to load"
end

local luasnip_status_ok, luasnip = pcall(require, "luasnip")
if not luasnip_status_ok then
    return "luasnip failed to load"
end

local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "ﯟ",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

local sources = {
    -- FORMAT: source name, CMP menu hint
    { "nvim_lsp", "[LSP]" },
    { "nvim_lua", "[NVIM_API]" },
    { "luasnip", "[Snippet]" },
    { "buffer", "[Buffer]" },
    { "path", "[Path]"}
}

local formatting_style = {
    -- default fields order i.e completion word + item.kind + item.kind icons
    fields = { "abbr", "kind", "menu" },
    format = function(entry, vim_item)
        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
        vim_item.menu = (function()
            local list = {}
            for _, label in ipairs(sources) do
                list[label[1]] = label[2]
            end
            return list
        end
        )()[entry.source.name]
        return vim_item
    end,
}

local options = {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- Just for luasnip
        end
    },
    mapping = {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-1),
        ["<C-f>"] = cmp.mapping.scroll_docs(1),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm { select },
        ["<Tab>"] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end,
            { "i", "s" }
        ),
        ["<S-Tab>"] = cmp.mapping(
            function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end,
            { "i", "s" }
        )
    },
    formatting = formatting_style,
    sources = {}, -- Appended later in for loop below
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    }
}

for _,source in ipairs(sources) do
    table.insert(options.sources, { name = source[1] })
end

return options
