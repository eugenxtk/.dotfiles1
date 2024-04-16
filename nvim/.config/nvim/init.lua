vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set mousehide")
vim.g.mapleader = " "
vim.opt.fillchars = {eob = " "}

-- Apply colorscheme
vim.cmd([[
  " VIM color file
  "
  " Note: Based on the 1337 theme for Sublime Text
  " by Mark Herpich

  hi clear

  set background=dark
  if version > 580
    if exists("syntax_on")
      syntax reset
    endif
  endif

  set t_Co=256
  let g:colors_name="1337"

  hi Character       guifg=#fdb082 guibg=None guisp=None gui=None ctermfg=216 ctermbg=None cterm=None
  hi Comment         guifg=#6d6d6d guibg=None guisp=None gui=None ctermfg=242 ctermbg=None cterm=None
  hi Constant        guifg=#fdb082 guibg=None guisp=None gui=None ctermfg=216 ctermbg=None cterm=None
  hi Cursor          guifg=None guibg=#F8F8F0 guisp=None gui=None ctermfg=None ctermbg=255 cterm=None
  hi CursorLine      guifg=None guibg=#3D3D3D55 guisp=None gui=None ctermfg=None ctermbg=None cterm=None
  hi Function        guifg=#8cdaff guibg=None guisp=None gui=None ctermfg=117 ctermbg=None cterm=None
  hi Identifier      guifg=#e9fdac guibg=None guisp=None gui=None ctermfg=193 ctermbg=None cterm=None
  hi Keyword         guifg=#ff5e5e guibg=None guisp=None gui=None ctermfg=203 ctermbg=None cterm=None
  hi LineNr          guifg=None guibg=None guisp=None gui=None ctermfg=None ctermbg=None cterm=None
  hi Normal          guifg=#F8F8F2 guibg=#191919 guisp=None gui=None ctermfg=255 ctermbg=234 cterm=None
  hi Number          guifg=#fdb082 guibg=None guisp=None gui=None ctermfg=216 ctermbg=None cterm=None
  hi Statement       guifg=#d0d0d0 guibg=None guisp=None gui=None ctermfg=252 ctermbg=None cterm=None
  hi StorageClass    guifg=#ff5e5e guibg=None guisp=None gui=None ctermfg=203 ctermbg=None cterm=None
  hi String          guifg=#fbe3bf guibg=None guisp=None gui=None ctermfg=223 ctermbg=None cterm=None
  hi Type            guifg=#8cdaff guibg=None guisp=None gui=None ctermfg=117 ctermbg=None cterm=None
  hi Visual          guifg=None guibg=#515151 guisp=None gui=None ctermfg=None ctermbg=239 cterm=None

  hi link Conditional Keyword
  hi link Repeat Keyword

  hi link cType Keyword
]])

-- Run lazy.nvim as plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
      "nvim-telescope/telescope.nvim", 
      branch = "0.1.x",
      dependencies = { "nvim-lua/plenary.nvim" }
    },

    {
      "nvim-treesitter/nvim-treesitter", 
      build = ":TSUpdate"
    },

    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" }
    },

    { 
      "SidOfc/carbon.nvim" 
    },

    {
      "nvim-tree/nvim-tree.lua"
    },

    {
      "neovim/nvim-lspconfig"
    }
}

local opts = {}

require("lazy").setup(plugins, opts)

-- Telescope config
require("telescope").setup({
  pickers = { 
    find_files = { hidden = true } 
  },
  defaults = {
    file_ignore_patterns = { ".git" }
  }
})

local telescope_builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
-- vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})
-- vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})

-- Treesitter config
local treesitter_config = require("nvim-treesitter.configs")
treesitter_config.setup({
  ensure_installed = { "lua", "vim", "html", "python" },
  highlight = { enable = true },
  indent = { enable = true }
})

-- Lualine config
require("lualine").setup()

-- Carbon config
require("carbon").setup()

-- Tree config
require("nvim-tree").setup()

local tree_api = require("nvim-tree.api")
vim.keymap.set('n', '<leader>e', tree_api.tree.toggle, {})

-- LSPs config

-- Python LSP
require("lspconfig").ruff_lsp.setup {}
