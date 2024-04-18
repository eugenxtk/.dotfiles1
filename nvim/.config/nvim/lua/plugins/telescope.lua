return {
  "nvim-telescope/telescope.nvim",
  branch = '0.1.x',
  dependencies = { 
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim"
  },
  config = function()
    require("telescope").setup({
      pickers = { 
        find_files = { hidden = true } 
      },
      defaults = {
        file_ignore_patterns = { ".git" }
      }
    })

    local telescope_builtin = require("telescope.builtin")
    require("telescope").load_extension "file_browser"
    
    local telescope_file_browser = require("telescope").extensions.file_browser

    vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', function()
      telescope_file_browser.file_browser({ hidden = { file_browser = true } })
    end)
  end
}
