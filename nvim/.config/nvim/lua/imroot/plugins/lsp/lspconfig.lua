return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        -- "saghen/blink.cmp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        -- Automatically install LSPs and related tools to stdpath for neovim
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',

        -- Useful status updates for LSP.
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        {
        'j-hui/fidget.nvim',
        tag = 'v1.4.0',
        opts = {
            progress = {
            display = {
                done_icon = '✓', -- Icon shown when all LSP progress tasks are complete
            },
            },
            notification = {
            window = {
                winblend = 0, -- Background color opacity in the notification window
            },
            },
        },
        },
    },
    -- config = function()
    --     -- NOTE: LSP Keybinds

    --     vim.api.nvim_create_autocmd("LspAttach", {
    --         group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    --         callback = function(ev)
    --             -- Buffer local mappings
    --             -- Check `:help vim.lsp.*` for documentation on any of the below functions
    --             local opts = { buffer = ev.buf, silent = true }

    --             -- keymaps
    --             opts.desc = "Show LSP references"
    --             vim.keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

    --             opts.desc = "Go to declaration"
    --             vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

    --             opts.desc = "Show LSP definitions"
    --             vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

    --             opts.desc = "Show LSP implementations"
    --             vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

    --             opts.desc = "Show LSP type definitions"
    --             vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

    --             opts.desc = "See available code actions"
    --             vim.keymap.set({ "n", "v" }, "<leader>vca", function() vim.lsp.buf.code_action() end, opts) -- see available code actions, in visual mode will apply to selection

    --             opts.desc = "Smart rename"
    --             vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

    --             opts.desc = "Show buffer diagnostics"
    --             vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

    --             opts.desc = "Show line diagnostics"
    --             vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

    --             opts.desc = "Show documentation for what is under cursor"
    --             vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

    --             opts.desc = "Restart LSP"
    --             vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

    --             vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    --         end,
    --     })


    --     -- NOTE : Moved all this to Mason including local variables
    --     -- used to enable autocompletion (assign to every lsp server config)
    --     -- local capabilities = cmp_nvim_lsp.default_capabilities()
    --     -- Change the Diagnostic symbols in the sign column (gutter)

    --     -- Define sign icons for each severity
    --     local signs = {
    --         [vim.diagnostic.severity.ERROR] = " ",
    --         [vim.diagnostic.severity.WARN]  = " ",
    --         [vim.diagnostic.severity.HINT]  = "󰠠 ",
    --         [vim.diagnostic.severity.INFO]  = " ",
    --     }

    --     -- Set the diagnostic config with all icons
    --     vim.diagnostic.config({
    --         signs = {
    --             text = signs -- Enable signs in the gutter
    --         },
    --         virtual_text = true,  -- Specify Enable virtual text for diagnostics
    --         underline = true,     -- Specify Underline diagnostics
    --         update_in_insert = false,  -- Keep diagnostics active in insert mode
    --     })


    --     -- NOTE : 
    --     -- Moved back from mason_lspconfig.setup_handlers from mason.lua file
    --     -- as mason setup_handlers is deprecated & its causing issues with lsp settings
    --     --
    --     -- Setup servers
    --     local lspconfig = require("lspconfig")
    --     local cmp_nvim_lsp = require("cmp_nvim_lsp")
    --     local capabilities = cmp_nvim_lsp.default_capabilities()

    --     -- Config lsp servers here
    --     -- lua_ls
    --     lspconfig.lua_ls.setup({
    --         capabilities = capabilities,
    --         settings = {
    --             Lua = {
    --                 diagnostics = {
    --                     globals = { "vim" },
    --                 },
    --                 completion = {
    --                     callSnippet = "Replace",
    --                 },
    --                 workspace = {
    --                     library = {
    --                         [vim.fn.expand("$VIMRUNTIME/lua")] = true,
    --                         [vim.fn.stdpath("config") .. "/lua"] = true,
    --                     },
    --                 },
    --             },
    --         },
    --     })
    --     -- emmet_ls
    --     lspconfig.emmet_ls.setup({
    --         capabilities = capabilities,
    --         filetypes = {
    --             "html",
    --             "typescriptreact",
    --             "javascriptreact",
    --             "css",
    --             "sass",
    --             "scss",
    --             "less",
    --             "svelte",
    --         },
    --     })

    --     -- emmet_language_server
    --     lspconfig.emmet_language_server.setup({
    --         capabilities = capabilities,
    --         filetypes = {
    --             "css",
    --             "eruby",
    --             "html",
    --             "javascript",
    --             "javascriptreact",
    --             "less",
    --             "sass",
    --             "scss",
    --             "pug",
    --             "typescriptreact",
    --         },
    --         init_options = {
    --             includeLanguages = {},
    --             excludeLanguages = {},
    --             extensionsPath = {},
    --             preferences = {},
    --             showAbbreviationSuggestions = true,
    --             showExpandedAbbreviation = "always",
    --             showSuggestionsAsSnippets = false,
    --             syntaxProfiles = {},
    --             variables = {},
    --         },
    --     })

    --     -- denols
    --     lspconfig.denols.setup({
    --         capabilities = capabilities,
    --         root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
    --     })

    --     -- ts_ls (replaces tsserver)
    --     lspconfig.ts_ls.setup({
    --         capabilities = capabilities,
    --         root_dir = function(fname)
    --             local util = lspconfig.util
    --             return not util.root_pattern("deno.json", "deno.jsonc")(fname)
    --                 and util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git")(fname)
    --         end,
    --         single_file_support = false,
    --         init_options = {
    --             preferences = {
    --                 includeCompletionsWithSnippetText = true,
    --                 includeCompletionsForImportStatements = true,
    --             },
    --         },
    --     })




    --     -- HACK: If using Blink.cmp Configure all LSPs here

    --     -- ( comment the ones in mason )
    --     -- local lspconfig = require("lspconfig")
    --     -- local capabilities = require("blink.cmp").get_lsp_capabilities() -- Import capabilities from blink.cmp

    --     -- Configure lua_ls
    --     -- lspconfig.lua_ls.setup({
    --     --     capabilities = capabilities,
    --     --     settings = {
    --     --         Lua = {
    --     --             diagnostics = {
    --     --                 globals = { "vim" },
    --     --             },
    --     --             completion = {
    --     --                 callSnippet = "Replace",
    --     --             },
    --     --             workspace = {
    --     --                 library = {
    --     --                     [vim.fn.expand("$VIMRUNTIME/lua")] = true,
    --     --                     [vim.fn.stdpath("config") .. "/lua"] = true,
    --     --                 },
    --     --             },
    --     --         },
    --     --     },
    --     -- })
    --     --
    --     -- -- Configure tsserver (TypeScript and JavaScript)
    --     -- lspconfig.ts_ls.setup({
    --     --     capabilities = capabilities,
    --     --     root_dir = function(fname)
    --     --         local util = lspconfig.util
    --     --         return not util.root_pattern('deno.json', 'deno.jsonc')(fname)
    --     --             and util.root_pattern('tsconfig.json', 'package.json', 'jsconfig.json', '.git')(fname)
    --     --     end,
    --     --     single_file_support = false,
    --     --     on_attach = function(client, bufnr)
    --     --         -- Disable formatting if you're using a separate formatter like Prettier
    --     --         client.server_capabilities.documentFormattingProvider = false
    --     --     end,
    --     --     init_options = {
    --     --         preferences = {
    --     --             includeCompletionsWithSnippetText = true,
    --     --             includeCompletionsForImportStatements = true,
    --     --         },
    --     --     },
    --     -- })

    --     -- Add other LSP servers as needed, e.g., gopls, eslint, html, etc.
    --     -- lspconfig.gopls.setup({ capabilities = capabilities })
    --     -- lspconfig.html.setup({ capabilities = capabilities })
    --     -- lspconfig.cssls.setup({ capabilities = capabilities })
    -- end,
-- New Python Custom LSP configuration
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        -- Create a function that lets us more easily define mappings specific LSP related items.
        -- It sets the mode, buffer and description for us each time.
        callback = function(event)
            local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
            end

            -- Jump to the definition of the word under your cursor.
            --  This is where a variable was first declared, or where a function is defined, etc.
            --  To jump back, press <C-T>.
            map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

            -- Find references for the word under your cursor.
            map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

            -- Jump to the implementation of the word under your cursor.
            --  Useful when your language has ways of declaring types without an actual implementation.
            map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

            -- Jump to the type of the word under your cursor.
            --  Useful when you're not sure what type a variable is and you want to see
            --  the definition of its *type*, not where it was *defined*.
            map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

            -- Fuzzy find all the symbols in your current document.
            --  Symbols are things like variables, functions, types, etc.
            map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

            -- Fuzzy find all the symbols in your current workspace
            --  Similar to document symbols, except searches over your whole project.
            map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

            -- Rename the variable under your cursor
            --  Most Language Servers support renaming across files, etc.
            map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

            -- Execute a code action, usually your cursor needs to be on top of an error
            -- or a suggestion from your LSP for this to activate.
            map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

            -- Opens a popup that displays documentation about the word under your cursor
            --  See `:help K` for why this keymap
            map('K', vim.lsp.buf.hover, 'Hover Documentation')

            -- WARN: This is not Goto Definition, this is Goto Declaration.
            --  For example, in C this would take you to the header
            map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

            map('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
            map('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
            map('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, '[W]orkspace [L]ist Folders')

            -- The following two autocommands are used to highlight references of the
            -- word under your cursor when your cursor rests there for a little while.
            --    See `:help CursorHold` for information about when this is executed
            --
            -- When you move your cursor, the highlights will be cleared (the second autocommand).
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                buffer = event.buf,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                callback = vim.lsp.buf.clear_references,
            })
            end
        end,
        })

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

        -- Enable the following language servers
        local servers = {
        lua_ls = {
            -- cmd = {...},
            -- filetypes { ...},
            -- capabilities = {},
            settings = {
            Lua = {
                runtime = { version = 'LuaJIT' },
                workspace = {
                checkThirdParty = false,
                -- Tells lua_ls where to find all the Lua files that you have loaded
                -- for your neovim configuration.
                library = {
                    '${3rd}/luv/library',
                    unpack(vim.api.nvim_get_runtime_file('', true)),
                },
                -- If lua_ls is really slow on your computer, you can try this instead:
                -- library = { vim.env.VIMRUNTIME },
                },
                completion = {
                callSnippet = 'Replace',
                },
                telemetry = { enable = false },
                diagnostics = { disable = { 'missing-fields' } },
            },
            },
        },
        pylsp = {
            settings = {
            pylsp = {
                plugins = {
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                mccabe = { enabled = false },
                pylsp_mypy = { enabled = false },
                pylsp_black = { enabled = false },
                pylsp_isort = { enabled = false },
                },
            },
            },
        },
        -- basedpyright = {
        --   -- Config options: https://github.com/DetachHead/basedpyright/blob/main/docs/settings.md
        --   settings = {
        --     basedpyright = {
        --       disableOrganizeImports = true, -- Using Ruff's import organizer
        --       disableLanguageServices = false,
        --       analysis = {
        --         ignore = { '*' },                 -- Ignore all files for analysis to exclusively use Ruff for linting
        --         typeCheckingMode = 'off',
        --         diagnosticMode = 'openFilesOnly', -- Only analyze open files
        --         useLibraryCodeForTypes = true,
        --         autoImportCompletions = true,     -- whether pyright offers auto-import completions
        --       },
        --     },
        --   },
        -- },
        ruff = {
            -- Notes on code actions: https://github.com/astral-sh/ruff-lsp/issues/119#issuecomment-1595628355
            -- Get isort like behavior: https://github.com/astral-sh/ruff/issues/8926#issuecomment-1834048218
            commands = {
            RuffAutofix = {
                function()
                vim.lsp.buf.execute_command {
                    command = 'ruff.applyAutofix',
                    arguments = {
                    { uri = vim.uri_from_bufnr(0) },
                    },
                }
                end,
                description = 'Ruff: Fix all auto-fixable problems',
            },
            RuffOrganizeImports = {
                function()
                vim.lsp.buf.execute_command {
                    command = 'ruff.applyOrganizeImports',
                    arguments = {
                    { uri = vim.uri_from_bufnr(0) },
                    },
                }
                end,
                description = 'Ruff: Format imports',
            },
            },
        },
        jsonls = {},
        sqlls = {},
        terraformls = {},
        yamlls = {},
        bashls = {},
        dockerls = {},
        docker_compose_language_service = {},
        -- tailwindcss = {},
        -- graphql = {},
        -- html = { filetypes = { 'html', 'twig', 'hbs' } },
        -- cssls = {},
        -- ltex = {},
        -- texlab = {},
        }

        -- Ensure the servers and tools above are installed
        require('mason').setup()

        -- You can add other tools here that you want Mason to install
        -- for you, so that they are available from within Neovim.
        local ensure_installed = vim.tbl_keys(servers or {})
        vim.list_extend(ensure_installed, {
        'stylua', -- Used to format lua code
        })
        require('mason-tool-installer').setup { ensure_installed = ensure_installed }

        require('mason-lspconfig').setup {
        handlers = {
            function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
            end,
        },
        }
    end,

}
