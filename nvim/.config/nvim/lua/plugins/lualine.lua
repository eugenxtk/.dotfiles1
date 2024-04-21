return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup {
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { "diff" },
          lualine_x = { },
          lualine_y = { "filename" },
          lualine_z = { "location" }
        },
        options = { disabled_filetypes = { "carbon.explorer", "NvimTree" } } 
      }
    end
}
