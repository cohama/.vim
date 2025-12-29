local nvim_lsp = require('lspconfig')
local configs = require('lspconfig.configs')
local util = require('lspconfig.util')

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
  vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover({ border = "single" })<CR>', {buffer = ev.buf})
  vim.keymap.set('n', 'gD', '<Cmd>vs<CR><Cmd>lua vim.lsp.buf.definition()<CR>', {buffer = ev.buf})
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {buffer = ev.buf})
  vim.keymap.set('n', '\\ni', '<cmd>lua vim.lsp.buf.implementation()<CR>', {buffer = ev.buf})
  vim.keymap.set('n', '\\nk', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {buffer = ev.buf})
  vim.keymap.set('n', '\\nD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {buffer = ev.buf})
  vim.keymap.set('n', '<M-r>', '<cmd>lua vim.lsp.buf.rename()<CR>', {buffer = ev.buf})
  vim.keymap.set('n', '\\nca', '<cmd>lua vim.lsp.buf.code_action()<CR>', {buffer = ev.buf})
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {buffer = ev.buf})
  vim.keymap.set('n', '\\ne', '<cmd>lua vim.diagnostic.open_float({ border = "single" })<CR>', {buffer = ev.buf})
  vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.jump({ count = -1, float = { border = "single" } })<CR>', {buffer = ev.buf})
  vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.jump({ count = 1, float = { border = "single" } })<CR>', {buffer = ev.buf})
  vim.keymap.set('n', '\\nq', '<cmd>lua vim.diagnostic.setloclist()<CR>', {buffer = ev.buf})
  vim.keymap.set('n', '\\nf', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', {buffer = ev.buf})
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = on_attach
})

vim.lsp.config('ty', {
  cmd = {'uvx', 'ty', 'server'},
  settings = {
    ty = {

    },
  }
})
vim.lsp.enable('ty')

vim.lsp.config('ruff', {
  cmd = {'uvx', 'ruff', 'server'},
  init_options = {
    settings = {
      lineLength = 120,
      organizeImports = true,
      fixAll = true,
      format = {
        preview = true,
      },
      lint = {
        select = {'ALL', 'I'},
        ignore = {
          'ANN101', 'ANN102',
          'BLE001',
          'D10', 'D202', 'D203', 'D213', 'D403', 'D400', 'D413', 'D415',
          'EM101', 'EM102',
          'FIX002',
          'PLR0913', 'PLR2004',
          'PT018',
          'PTH123',
          'PYI041',
          'RET505',
          'RUF001', 'RUF002', 'RUF003', 'RUF005',
          'S101', 'S311', 'S324',
          'T20', 'TD002', 'TD003',
          'TRY003',
          'COM812',
          'ISC001',
        },
      },
    }
  }
})
vim.lsp.enable('ruff')


vim.lsp.config('efm', {
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
})
vim.lsp.enalbe('efm')

vim.lsp.enable('rust_analyzer')

vim.lsp.config['hls'] = {
  cmd = {'ghcup', 'run', '--ghc', '9.4.8', '--', 'haskell-language-server-wrapper', 'lsp'},
  filetypes = {'haskell'},
  root_markers = {'stack.yaml', 'cabal.project', 'cabal.project.local', 'hie.yaml', '.git', 'xmonad.hs'},
  single_file_support = true,
  settings = {
    haskell = {
      formattingProvider = 'fourmolu',
      hlintOn = true,
      plugins = {
        ghcide = {
          showTypeErrors = true,
          showWarnings = true,
        },
      },
    },
  },
  on_attach = on_attach,
}
vim.lsp.enable('hls')

vim.lsp.config['biome'] = {
  cmd = {'biome', 'lsp-proxy'},
  filetypes = {'astro', 'css', 'graphql', 'html', 'javascript', 'javascriptreact', 'json', 'jsonc', 'svelte', 'typescript', 'typescript.tsx', 'typescriptreact', 'vue'},
  workspace_required = true,
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local root_files = { 'biome.json', 'biome.jsonc' }
    root_files = util.insert_package_json(root_files, 'biome', fname)
    local root_dir = vim.fs.dirname(vim.fs.find(root_files, { path = fname, upward = true })[1])
    on_dir(root_dir)
  end,
}
vim.lsp.enable('biome')

vim.lsp.config('ts_ls', {
  root_markers = { 'tsconfig.json', 'package.json' },
})
vim.lsp.enable('ts_ls')
