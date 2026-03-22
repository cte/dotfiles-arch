return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local servers = {
        bashls = {},
        cssls = {},
        html = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              format = {
                enable = true,
              },
              workspace = {
                checkThirdParty = false,
              },
              telemetry = {
                enable = false,
              },
            },
          },
        },
        marksman = {},
        nil_ls = {},
        ts_ls = {},
        yamlls = {},
      }

      local executables = {
        bashls = "bash-language-server",
        cssls = "vscode-css-language-server",
        html = "vscode-html-language-server",
        jsonls = "vscode-json-language-server",
        lua_ls = "lua-language-server",
        marksman = "marksman",
        nil_ls = "nil",
        ts_ls = "typescript-language-server",
        yamlls = "yaml-language-server",
      }

      for name, config in pairs(servers) do
        config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
        vim.lsp.config(name, config)
      end

      for name, bin in pairs(executables) do
        if vim.fn.executable(bin) == 1 then
          vim.lsp.enable(name)
        end
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("cte_nvim_lsp", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", vim.lsp.buf.definition, "Goto definition")
          map("gD", vim.lsp.buf.declaration, "Goto declaration")
          map("gr", vim.lsp.buf.references, "References")
          map("gI", vim.lsp.buf.implementation, "Goto implementation")
          map("K", vim.lsp.buf.hover, "Hover")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "v" })
          map("<leader>cl", function()
            vim.lsp.codelens.run()
          end, "CodeLens action")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method("textDocument/inlayHint") then
            vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
          end
        end,
      })
    end,
  },
}
