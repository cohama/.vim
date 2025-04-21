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

nvim_lsp.gopls.setup{}

function pylsp_default_settings()
  return {
    pylsp = {
      plugins = {
        ruff = {
          enabled = true,
          formatEnabled = true,
          select = {"ALL"},
          format = {"I"},
          ignore = {
            "ANN101", "ANN102",
            "BLE001",
            "D10", "D202", "D203", "D213", "D403", "D400", "D413", "D415",
            "EM101", "EM102",
            "FIX002",
            "PLR0913", "PLR2004",
            "PT018",
            "PTH123",
            "PYI041",
            "RET505",
            "RUF001", "RUF002", "RUF003", "RUF005",
            "S101", "S311", "S324",
            "T20", "TD002", "TD003",
            "TRY003",
            "COM812",
            "ISC001",
          },
          lineLength = 120,
        },
        pylint = {
          enabled = false,
          args = {"-j0"},
        },
        pycodestyle = {
          enabled = false,
        },
        flake8 = {
          enabled = false,
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
          enabled = false,
        },
        mccabe = {
          enabled = false,
        },
        isort = {
          enabled = false,
        },
        black = {
          enabled = false,
        },
        rope_autoimport = {
          enabled = false,
        },
      }
    }
  }
end

function is_pylint_root_dir(fname)
  local root_dir = vim.fs.root(fname, "pyproject.toml")
  local pyproject_toml = vim.fs.joinpath(root_dir, "pyproject.toml")
  local lines = vim.iter(vim.fn.readfile(pyproject_toml))
  return lines:find(function(line)
    return string.match(line, "tool.pylint")
  end) ~= nil
end

function python_root_dir(fname)
  local root_files = {"pyproject.toml", "setup.py", ".git"}
  local root_dir = util.root_pattern(unpack(root_files))(fname)
  return root_dir
end

nvim_lsp.pylsp.setup {
  cmd = {vim.env.HOME .. "/.config/nvim/run_pylsp.sh"},
  flags = {
    debounce_text_changes = 500,
    allow_incremental_sync = false,
  },
  root_dir = function(fname)
    local root_dir = python_root_dir(fname)
    if not is_pylint_root_dir(fname) then
      return root_dir
    end
  end,
  on_attach = function(client, bufnr)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    if is_pylint_root_dir(fname) then
      vim.schedule(function()
        vim.lsp.buf_detach_client(bufnr, client["id"])
      end)
    end
  end,
  settings = pylsp_default_settings()
}

configs.pylsp_pylint = {
  default_config = {
    cmd = {vim.env.HOME .. '/.config/nvim/run_pylsp.sh'},
    filetypes = {'python'},
    root_dir = function(fname)
      local root_dir = python_root_dir(fname)
      if is_pylint_root_dir(fname) then
        return root_dir
      end
    end,
    single_file_support = false,
    settings = vim.tbl_extend(
      "force",
      pylsp_default_settings(),
      {
        pylsp = {
          plugins = {
            ruff = {
              enabled = false,
            },
            pylint = {
              enabled = true,
            },
            isort = {
              enabled = true,
            },
            black = {
              enabled = true,
            },
          },
        },
      }
    ),
  },
}

nvim_lsp.pylsp_pylint.setup {}

nvim_lsp.efm.setup {
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
}

nvim_lsp.hls.setup{
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
