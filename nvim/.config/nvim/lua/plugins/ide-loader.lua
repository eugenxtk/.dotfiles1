return {
  { 
    "williamboman/mason.nvim", 
    config = function()
      require("mason").setup()
    end
  },
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason-lspconfig.nvim" }
}
