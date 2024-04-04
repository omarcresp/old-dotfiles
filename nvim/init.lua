vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

local set = vim.opt

set.number = true
set.relativenumber = true

set.mouse = 'a'
set.clipboard = 'unnamedplus'

set.scrolloff = 10

set.updatetime = 350
set.timeoutlen = 400

-- Preview substitutions live, as you type!
set.inccommand = 'split'

-- Show which line your cursor is on
set.cursorline = true

-- Set highlight on search, but clear on pressing <Esc> in normal mode
set.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Don't show the mode, since it's already in status line
set.showmode = false

-- Save undo history and disables backups (undo plugin will take care of)
set.undofile = true
set.undodir = os.getenv 'HOME' .. '/.vim/undodir'
set.swapfile = false
set.backup = false

-- Dont wrap the lines that are longer
set.wrap = false

-- Identa
set.smartindent = true

-- Set the tab width
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4

-- Case-insensitive searching UNLESS \C or capital in search
set.ignorecase = true
set.smartcase = true

-- Keep signcolumn (where git symbols are show)
set.signcolumn = 'yes'

-- Term color
set.termguicolors = true

-- Shows trailling blank spaces
set.list = true
set.listchars = { trail = '·', nbsp = '␣', tab = '  ' }

-- TODO: PENDING TO REMAP
-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.setloclist, { desc = 'Open [E]rrors Quickfix list' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Redo
vim.keymap.set("n", "U", vim.cmd.redo)

-- Move selected text up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Next and Previous page
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- After search, n (next) and N (prev) now stay in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste without loosing current ref
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = '[P]aste without buffering' })

-- copy to the OS
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = '[Y]ank to the os also' })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = '[Y]ank to the os also' })

-- delete to void (not save in vim buffer)
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = '[D]eletes to the void' })

-- change to void (not save in vim buffer)
vim.keymap.set({ "n", "v" }, "<leader>c", [["_c]], { desc = '[C]hange to the void' })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-c>", "<cmd>bd<CR>")

-- Search for search and replace
vim.keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = '[S]earch and [R]eplace current word' })

-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = 'Marks E[X]ecutable current file' })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Yank buffer relative path to clipboard
vim.keymap.set("n", "<leader>y<leader>", function()
  vim.fn.setreg('+', vim.fn.expand '%')
end, { desc = '[Y]ank current file path' })

vim.keymap.set('n', '<leader>f', function()
  require("conform").format({ async = true, lsp_fallback = true })
  -- vim.lsp.buf.format()
end, { desc = '[F]ormat Document' })

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
set.rtp:prepend(lazypath)

local setTempl = {
  desc = 'Set templ filetype',
  group = vim.api.nvim_create_augroup('templ-filetype', { clear = true }),
  pattern = '*.templ',
  callback = function()
    vim.bo.filetype = 'templ'
  end,
}
vim.api.nvim_create_autocmd('BufRead', setTempl)
vim.api.nvim_create_autocmd('BufNewFile', setTempl)

vim.api.nvim_create_autocmd('BufWritePost', {
  desc = 'Run templ generate on buff save',
  group = vim.api.nvim_create_augroup('templ-generate', { clear = false }),
  pattern = '*.templ',
  callback = function()
    vim.cmd('!templ generate')
  end,
})

require('lazy').setup({
  -- Detect tab width based on current file or project (editorconfig also)
  'tpope/vim-sleuth',

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',         opts = {} },

  -- tmux nvim integration
  { "christoomey/vim-tmux-navigator" },

  -- Adds git related signs
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- Show pending keybinds.
  {
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      require('which-key').register {
        ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        -- ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        ['<leader>l'] = { name = '[L]SP', _ = 'which_key_ignore' },
      }
    end,
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      {
        'nvim-tree/nvim-web-devicons',
        enabled = vim.g.have_nerd_font,
      },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<C-p>', function()
        builtin.git_files({ show_untracked = true })
      end, {})
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>sv', vim.cmd.Ex, { desc = 'back to [S]earch [V]iew' })
      vim.keymap.set('n', '<leader>st', vim.cmd.TodoTelescope, { desc = '[S]earch [T]odos in project' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>s.', function()
        builtin.oldfiles({ cwd_only = true })
      end, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find existing buffers' })
      vim.keymap.set('n', '<leader>sc', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[S]earch in [C]urrent Buffer' })
    end,
  },

  -- LSP Configuration & Plugins
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP (the messages that appears bottom rigth)
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = '[L]SP - ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Jump to the implementation of the word under your cursor.
          map('<leader>li', require('telescope.builtin').lsp_references, 'Goto [I]mplementations')

          -- Fuzzy find all the symbols in your current document.
          map('<leader>ls', require('telescope.builtin').lsp_document_symbols, 'Search [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace
          map('<leader>lw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace Symbols')

          -- Rename the variable under your cursor
          --  Most Language Servers support renaming across files, etc.
          map('<leader>lr', vim.lsp.buf.rename, '[R]ename')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>lc', vim.lsp.buf.code_action, '[C]ode Action')

          -- Opens a popup that displays documentation about the word under your cursor
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
        end,
      })

      -- initialize cmp to work with LSP
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      local servers = {
        tsserver = {},

        prettierd = {},

        eslint_d = {},

        eslint = {},

        emmet_language_server = {
          filetypes = { 'html', 'templ' },
        },

        angularls = {},

        tailwindcss = {
          filetypes = { 'scss', 'html' },
        },

        templ = {},

        cssls = {},

        clangd = {},

        -- volar = {
        --   -- filetypes = { 'vue' },
        --   filetypes = {
        --     'typescript',
        --     'javascript',
        --     'javascriptreact',
        --     'typescriptreact',
        --     'vue',
        --     'json'
        --   },
        --   settings = {
        --     css = {
        --       validate = true,  -- Enable CSS validation
        --       lint = {
        --         enabled = true, -- Enable CSS linting
        --         debounce = 100, -- Debounce time for linting
        --       },
        --     },
        --   },
        -- },

        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
              },
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      -- NOTE: Didnt work in WSL out of the box
      -- vim.list_extend(ensure_installed, {
      --   'stylua', -- Used to format lua code
      -- })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  -- Autoformat
  {
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        javascript = { { 'prettierd', 'prettier', 'eslint_d', 'eslint' } },
        javascriptreact = { { 'prettierd', 'prettier', 'eslint_d', 'eslint' } },
        typescript = { { 'prettierd', 'prettier', 'eslint_d', 'eslint' } },
        typescriptreact = { { 'prettierd', 'prettier', 'eslint_d', 'eslint' } },
        go = { { 'gofmt', 'gofumpt' } },
      },
    },
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',

      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require 'cmp'
      local ls = require 'luasnip'
      ls.config.setup {}

      require("luasnip.loaders.from_vscode").load({ paths = "./snippets" })

      cmp.setup {
        snippet = {
          expand = function(args)
            ls.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<Enter>'] = cmp.mapping.confirm { select = true },

          -- Snippets
          ['<C-l>'] = cmp.mapping(function()
            if ls.expand_or_locally_jumpable() then
              ls.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if ls.locally_jumpable(-1) then
              ls.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  -- Theme
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'tokyonight-night'
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  -- Collection of various small independent plugins/modules
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      require('mini.ai').setup { n_lines = 500 }

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_filename = function()
        -- In terminal always use plain name
        if vim.bo.buftype == 'terminal' then
          return '%t'
        else
          return vim.fn.expand('%:~:.') .. '%m%r'
        end
      end

      local isnt_normal_buffer = vim.bo.buftype ~= ''

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_fileinfo = function()
        local filetype = vim.bo.filetype

        if not vim.g.have_nerd_font then return '' end
        if (filetype == '') or isnt_normal_buffer then return '' end

        local has_devicons, devicons = pcall(require, 'nvim-web-devicons')

        if not has_devicons then return '' end

        local file_name, file_ext = vim.fn.expand('%:t'), vim.fn.expand('%:e')
        local icon = devicons.get_icon(file_name, file_ext, { default = true })

        if icon ~= '' then return string.format('%s %s', icon, filetype) end

        return filetype
      end

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_git = function()
        if isnt_normal_buffer then return '' end

        local head = vim.b.gitsigns_head or '-'
        local icon = vim.g.have_nerd_font and '' or 'Git'

        if head == '-' or head == '' then return '' end
        return string.format('%s %s', icon, head)
      end

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_diagnostics = function()
        return ''
      end
    end,
  },
  {
    'theprimeagen/harpoon',
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      local harpoon = require("harpoon")
      pcall(require('telescope').load_extension, 'harpoon')
      local telescope = require("telescope");

      harpoon:setup()

      vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end, { desc = '[A]dd current file to Harpoon' })
      vim.keymap.set("n", '<C-e>', telescope.extensions.harpoon.marks)

      vim.keymap.set("n", "<C-f>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<C-n>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<C-s>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<C-m>", function() harpoon:list():select(4) end)
      vim.keymap.set("n", "<C-a>", function() harpoon:list():select(5) end)
    end
  },

  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = 'Toggle [U]ndotree' })
    end
  },

  -- Add indentation guides even on blank lines
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    opts = {},
  },
  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = { "windwp/nvim-ts-autotag", "nvim-treesitter/nvim-treesitter-context" },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'html',
          'lua',
          'typescript',
          'javascript'
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        autotag = {
          enable = true,
          enable_close_on_slash = true,
        }
      }
    end,
  },

  {
    'github/copilot.vim',
  },

  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set("n", "<leader>gg", vim.cmd.Git, { desc = '[G]it [S]tatus' })
      vim.keymap.set("n", "<leader>gb", "<cmd>G branch<CR>", { desc = '[G]it [B]ranch' })
    end,
  },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
