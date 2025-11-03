return {
  "neovim/nvim-lspconfig",
  config = function()
    -- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("ts_ls")
    -- vim.lsp.enable("pyright")

    -- Configure basedpyright with diagnostic settings
    vim.lsp.config("basedpyright", {
      settings = {
        basedpyright = {
          analysis = {
            diagnosticMode = "openFilesOnly",
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            typeCheckingMode = "standard",
          },
        },
      },
      handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(
          vim.lsp.diagnostic.on_publish_diagnostics, {
            update_in_insert = true,
          }
        ),
      },
    })
    vim.lsp.enable("basedpyright")

    vim.lsp.config("ruff", {
      handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(
          vim.lsp.diagnostic.on_publish_diagnostics, {
            update_in_insert = true,
          }
        ),
      },
    })
    vim.lsp.enable("ruff")
    -- vim.lsp.config("ty", {
    --   settings = {
    --     ty = {
    --       diagnosticMode = "workspace",
    --     },
    --   },
    -- })
    -- vim.lsp.enable("ty")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts)
        -- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end,
    })

    vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
      group = vim.api.nvim_create_augroup("DiagnosticRefresh", {}),
      callback = function()
        vim.diagnostic.show()
      end,
    })

    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        local opts = {
          focusable = false,
          close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
          scope = "cursor",
        }
        vim.diagnostic.open_float(nil, opts)
      end,
    })
  end,
}
