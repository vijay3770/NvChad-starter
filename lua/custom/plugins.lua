local plugins = {
  -- auto sessions reopens the buffers previously kept open
  {
    'rmagatti/auto-session',
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
   opts = {
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      -- log_level = 'debug',
    }
  },
  -- add lsp support for c++, python, rust
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = true,
      },
      {
        "williamboman/mason-lspconfig.nvim",
        version = "v1.23.0",
      },
      {
        "hrsh7th/nvim-cmp",
        dependencies = {
          "hrsh7th/cmp-nvim-lsp",
        },
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      -- Set up Mason LSP manager
      mason_lspconfig.setup({
        ensure_installed = { "clangd", "pyright", "rust_analyzer" },
      })

      -- nvim-cmp capabilities for LSP
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Apply settings for each LSP server
      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,
      })
    end,
  }
}

return plugins
