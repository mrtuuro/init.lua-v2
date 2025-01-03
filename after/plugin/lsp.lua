local lsp_zero = require('lsp-zero')

-- lsp_attach is where you enable features that only work
-- if there is a language server active in the file
local lsp_attach = function(client, bufnr)
    local opts = {buffer = bufnr}

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end

lsp_zero.extend_lspconfig({
    -- sign_text = true,
    lsp_attach = lsp_attach,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

require('lspconfig').gopls.setup({})
require('lspconfig').jdtls.setup({})
require('lspconfig').clangd.setup({
    cmd = {
        "clangd",
        "--compile-commands-dir=./build"
    },
    settings = {
        clangd = {
            fallbackFlags = {
                '--style={IndentWidth: 4}',
                '-I/opt/homebrew/Cellar/raylib/5.5/include',
                '-L/opt/homebrew/Cellar/raylib/5.5/lib -lraylib'
            },
        },
    },
})


require('mason').setup({})
-- require('mason-lspconfig').setup({
-- -- Replace the language servers listed here 
-- -- with the ones you want to install
-- ensure_installed = {'gopls', 'clangd'},
-- handlers = {
--   function(server_name)
--     require('lspconfig')[server_name].setup({})
--   end,
--   -- },
-- })

local cmp = require('cmp')

cmp.setup({
    sources = {
        {name = 'nvim_lsp'},
        {name = 'buffer'},
    },
    snippet = {
        expand = function(args)
            -- You need Neovim v0.10 to use vim.snippet
            vim.snippet.expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
})



lsp_zero.setup()
