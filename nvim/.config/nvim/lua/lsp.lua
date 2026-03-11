local function is_related_path(root_dir, pixi_project_root)
  if not root_dir or not pixi_project_root then
    return false
  end

  local root = vim.fs.normalize(root_dir)
  local pixi_root = vim.fs.normalize(pixi_project_root)

  return root == pixi_root
      or vim.startswith(root, pixi_root .. "/")
      or vim.startswith(pixi_root, root .. "/")
end

local function ty_cmd_env(root_dir)
  local global_pixi_prefix = vim.fs.normalize(vim.fn.expand("~/.pixi/envs/python"))

  if vim.env.PIXI_IN_SHELL == "1" then
    if not is_related_path(root_dir, vim.env.PIXI_PROJECT_ROOT) or not vim.env.CONDA_PREFIX then
      return nil
    end

    return {
      CONDA_PREFIX = vim.env.CONDA_PREFIX,
      CONDA_DEFAULT_ENV = vim.env.CONDA_DEFAULT_ENV,
      PATH = vim.env.PATH,
      PIXI_ENVIRONMENT_NAME = vim.env.PIXI_ENVIRONMENT_NAME,
      PIXI_EXE = vim.env.PIXI_EXE,
      PIXI_IN_SHELL = vim.env.PIXI_IN_SHELL,
      PIXI_PROJECT_MANIFEST = vim.env.PIXI_PROJECT_MANIFEST,
      PIXI_PROJECT_NAME = vim.env.PIXI_PROJECT_NAME,
      PIXI_PROJECT_ROOT = vim.env.PIXI_PROJECT_ROOT,
      PIXI_PROJECT_VERSION = vim.env.PIXI_PROJECT_VERSION,
      VIRTUAL_ENV = vim.env.CONDA_PREFIX,
    }
  end

  if vim.uv.fs_stat(global_pixi_prefix) == nil then
    return nil
  end

  return {
    CONDA_PREFIX = global_pixi_prefix,
    CONDA_DEFAULT_ENV = "python",
    PATH = global_pixi_prefix .. "/bin:" .. vim.env.PATH,
    VIRTUAL_ENV = global_pixi_prefix,
  }
end

local function ty_python_env(root_dir)
  local global_pixi_prefix = vim.fs.normalize(vim.fn.expand("~/.pixi/envs/python"))

  if vim.env.PIXI_IN_SHELL == "1"
      and is_related_path(root_dir, vim.env.PIXI_PROJECT_ROOT)
      and vim.env.CONDA_PREFIX then
    return vim.env.CONDA_PREFIX
  end

  if vim.uv.fs_stat(global_pixi_prefix) ~= nil then
    return global_pixi_prefix
  end

  return nil
end

return {
  "neovim/nvim-lspconfig",
  config = function()
    -- vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
    vim.lsp.config("lua_ls", {
      cmd = { "lua-language-server" }
    })
    vim.lsp.enable("lua_ls")
    vim.lsp.config("ts_ls", {
      cmd = { "typescript-language-server" }
    })
    vim.lsp.enable("ts_ls")

    -- vim.lsp.enable("pyright")

    -- Configure basedpyright with diagnostic settings
    -- vim.lsp.config("basedpyright", {
    --   settings = {
    --     basedpyright = {
    --       analysis = {
    --         diagnosticMode = "openFilesOnly",
    --         autoSearchPaths = true,
    --         useLibraryCodeForTypes = true,
    --         typeCheckingMode = "standard",
    --       },
    --     },
    --   },
    --   handlers = {
    --     ["textDocument/publishDiagnostics"] = vim.lsp.with(
    --       vim.lsp.diagnostic.on_publish_diagnostics, {
    --         update_in_insert = true,
    --       }
    --     ),
    --   },
    -- })
    -- vim.lsp.enable("basedpyright")

    -- vim.lsp.config("ruff", {
    --   handlers = {
    --     ["textDocument/publishDiagnostics"] = vim.lsp.with(
    --       vim.lsp.diagnostic.on_publish_diagnostics, {
    --         update_in_insert = true,
    --       }
    --     ),
    --   },
    -- })
    -- vim.lsp.enable("ruff")

    vim.lsp.config("ty", {
      root_markers = { "pixi.toml", "ty.toml", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
      before_init = function(_, config)
        config.cmd_env = ty_cmd_env(config.root_dir)
        config.settings = config.settings or {}
        config.settings.ty = config.settings.ty or {}
        config.settings.ty.configuration = config.settings.ty.configuration or {}
        config.settings.ty.configuration.environment = config.settings.ty.configuration.environment or {}
        config.settings.ty.configuration.environment.python = ty_python_env(config.root_dir)
      end,
      settings = {
        ty = {
          diagnosticMode = "workspace",
        },
      },
    })
    vim.lsp.enable("ty")

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
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
