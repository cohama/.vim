local nvim_lsp = require('lspconfig')

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    update_in_insert = false,
    virtual_text = {
      format = function(diagnostic)
        return string.format("%s (%s)", diagnostic.message, diagnostic.source)
      end
    },
    signs = function(namespace, bufnr)
      return vim.b[bufnr].show_signs == true
    end
  }
)
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(ev)
  vim.keymap.set('n', 'gD', '<Cmd>vs<CR><Cmd>lua vim.lsp.buf.definition()<CR>', {buffer = ev.buf})
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {buffer = ev.buf})
  vim.keymap.set('n', '\\ni', '<cmd>lua vim.lsp.buf.implementation()<CR>', {buffer = ev.buf})
  vim.keymap.set('n', '\\nk', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {buffer = ev.buf})
  vim.keymap.set('n', '\\nD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {buffer = ev.buf})
  vim.keymap.set('n', '<M-r>', '<cmd>lua vim.lsp.buf.rename()<CR>', {buffer = ev.buf})
  vim.keymap.set('n', '\\nca', '<cmd>lua vim.lsp.buf.code_action()<CR>', {buffer = ev.buf})
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {buffer = ev.buf})
  vim.keymap.set('n', '\\ne', '<cmd>lua vim.diagnostic.open_float({ border = "single" })<CR>', {buffer = ev.buf})
  vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', {buffer = ev.buf})
  vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', {buffer = ev.buf})
  vim.keymap.set('n', '\\nq', '<cmd>lua vim.diagnostic.setloclist()<CR>', {buffer = ev.buf})
  vim.keymap.set('n', '\\nf', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', {buffer = ev.buf})
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = on_attach
})

nvim_lsp.gopls.setup{
  on_attach = on_attach,
}

nvim_lsp.pylsp.setup {
  on_attach = on_attach,
  cmd = { vim.env.HOME .. "/.config/nvim/run_pylsp.sh" },
  flags = {
    debounce_text_changes = 500,
    allow_incremental_sync = false,
  },
  settings =  {
    pylsp = {
      plugins = {
        ruff = {
          enabled = false,
        },
        pylint = {
          enabled = true,
          args = {"-j0"},
        },
        pycodestyle = {
          enabled = false,
        },
        flake8 = {
          enabled = true,
        },
        pydocstyle = {
          enabled = false,
          addIgnore = {"D100", "D103", "D101", "D415", "D400", "D102", "D107", "D212", "D202", "D403", "D105"},
          convention = "google",
        },
        pyflakes = {
          enabled = false,
        },
        pylsp_mypy = {
          enabled = true,
        },
        mccabe = {
          enabled = false,
        },
        isort = {
          enabled = true,
        },
        black = {
          enabled = true,
        },
        rope_autoimport = {
          enabled = false,
        },
      }
    }
  }
}

nvim_lsp.efm.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 500,
  },
  filetypes = {'sh', 'dockerfile'},
  settings =  {
    rootMarkers = {'.git'},
    languages = {
      sh = {
        {
          lintCommand = 'shellcheck -f gcc -x',
          lintSource = 'shellcheck',
          lintFormats= {'%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m', '%f:%l:%c: %tote: %m'}
        },
      },
      dockerfile = {
        {
          lintCommand = 'hadolint --no-color',
          lintFormats = {'%f:%l DL%n %trror: %m', '%f:%l DL%n %tarning: %m'},
        },
      },
    }
  }
}

nvim_lsp.rust_analyzer.setup{
  on_attach = on_attach,
}

nvim_lsp.hls.setup{
  on_attach = on_attach,
}
-- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     float = true,
--     set_loclist
--   }
-- )

-- nvim_lsp.pylsp.setup {
-- cmd = { 'pylsp', '--log-file', '/home/cohama/pylsp.log' }
-- }
