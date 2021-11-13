
-- local nvim_lsp = require('lspconfig')
-- local lsp_installer = require("nvim-lsp-installer")

local M = {}

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local commands = {
        l = {
            name = "lsp",
            d = {"<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition"},
            D = {"<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration"},
            r = {"<cmd>lua vim.lsp.buf.references()<CR>", "Go to references"},
            i = {"<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation"},
            k = {"<cmd>lua vim.lsp.buf.hover()<CR>", "Show info"},
            K = {"<cmd>lua vim.lsp.buf.signature_help()<CR>", "Show signature"},
            p = {"<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Diagnostic prev"},
            o = {"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Diagnostic next"},
            n = {"<cmd>lua vim.lsp.buf.rename()<CR>" , "Rename" },
            a = {"<cmd>lua vim.lsp.buf.code_action()<CR>" , "Actions" },
            e = {"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>" , "Diagnostics" },
            f = {"<cmd>lua vim.lsp.buf.formatting()<CR>" , "Formatting" },
            A = {":Lspsaga code_action<CR>", "Actions!"},
        },
    }
    opts = require "plugins.config.which-key" . opts('n')

    require("which-key") . register(commands, opts)

    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

    require 'completion' . on_attach(client, bufnr)
    require 'lsp_signature' . on_attach()
end

function M.setup()
    require('lspkind').init()
    require('lspsaga').init_lsp_saga()

    local icons = {
        Class = " ",
        Color = " ",
        Constant = "ﲀ ",
        Constructor = " ",
        Enum = "練",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = "",
        Folder = " ",
        Function = " ",
        Interface = "ﰮ ",
        Keyword = " ",
        Method = " ",
        Module = " ",
        Operator = "",
        Property = " ",
        Reference = " ",
        Snippet = " ",
        Struct = " ",
        Text = " ",
        TypeParameter = " ",
        Unit = "塞",
        Value = " ",
        Variable = " ",
    }

    local kinds = vim.lsp.protocol.CompletionItemKind
    for i,kind in ipairs(kinds) do
        kinds[i] = icons[kind] or kind
    end

    local lspplugin = require "nvim-lsp-installer"
    local status_ok, lspplugin = pcall(require, "nvim-lsp-installer")
    if not status_ok then
        return
    end


    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            'documentation',
            'detail',
            'additionalTextEdits',
        }
    }

    lspplugin . on_server_ready(function(server)
        local opts = {
            on_attach = on_attach,
            flags = {
            debounce_text_changes = 150,
            },
            kinds = kinds
        }

        -- (optional) Customize the options passed to the server
        if server.name == "intelephense" then
            -- opts.root_dir = function() ... end
            opts.capabilities = capabilities
            opts.init_options = {
                licenceKey = os.getenv('INTELEPHENSELICENCE'),
            }
            opts.settings = {
                intelephense = {
                    telemetry = {
                        enabled = false,
                    },
                    completion = {
                        fullyQualifyGlobalConstantsAndFunctions = false
                    },
                    phpdoc = {
                        returnVoid = false,
                    }
                },
            }
        end

        -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
        server:setup(opts)
        cmd [[ do User LspAttachBuffers ]]
    end)
end

return M
