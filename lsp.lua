local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '\\ni', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '\\nk', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '\\nwa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '\\nwr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '\\nwl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '\\nD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<M-r>', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '\\nca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '\\ne', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '\\nq', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '\\nf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

nvim_lsp.pylsp.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 100,
  },
  settings =  {
    pylsp = {
      plugins = {
        pylint = {
          enabled = false,
        },
        pycodestyle = {
          enabled = false,
        },
        pyflakes = {
          enabled = false,
        },
        pyls_mypy = {
          enabled = false,
        },
        mccabe = {
          enabled = false,
        },
        mypy = {
          enabled = false,
        }
      }
    }
  }
}

nvim_lsp.efm.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 100,
  },
  filetypes = {'sh'},
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
    }
  }
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
