local fn = vim.fn

-- Automatically install packer
-- (1) We get the install path first
-- (2) if the path is ISN'T there then we basically git clone it so that it is there!
-- (3) "data" = ~/.local/share/nvim
-- (4) opt = directory for optional plugins
-- (5) start = directory for plugins running at startup. 
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- (1) when the event "BufWritePost" happens (i.e you write to the file plugins.lua) you'll source the file THEN run the command Packersync (from packer)
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
-- (1) basically the same as storing the packer module in a variable like the following line of code. But in this way, we don't die when something wrong happens. 
-- local packer = require("Packer") 
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  print("something went wrong when I called packer module")
  return
end


-- Have packer use a popup window
-- basically makes a floating window with rounder boarders
-- if you didn't have this, it just does a vertical split instead. lol
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

---------------------------------------------- we only care about the below section ------------------------------------------------
-- You'll only be touching the use "[string]" below where the string is in the form "user/repo"

-- Install your plugins here
return packer.startup(function(use)

  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  -- View a preview of markdown
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = "MarkdownPreview", ft = "markdown"}

  -- repeating, surrounding and commentary
  use "tpope/vim-repeat"
  use "tpope/vim-surround"
  use "tpope/vim-commentary"

  -- more text objects
  use "michaeljsmith/vim-indent-object"
  use "kana/vim-textobj-user"
  use "kana/vim-textobj-entire"
  use "kana/vim-textobj-line"

  -- colorschemes
  use "lunarvim/colorschemes" -- this gets you, "aurora", "codemonkey", "darkplus", "onedarker", "spacedark", "system76"
  use "folke/tokyonight.nvim" -- this gets you the "tokyonight" colorscheme

  -- completion plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- The completion plugin
  use "hrsh7th/cmp-path" -- The completion plugin
  use "hrsh7th/cmp-cmdline" -- The completion plugin
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp" -- This provides completions from the lsp source
  use "hrsh7th/cmp-nvim-lua" -- completion for lua. 

  -- snippets
  use "L3MON4D3/LuaSnip" -- snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer. super easy to install, delete and update


  -- Telescope
  use "nvim-telescope/telescope.nvim"
  --use 'nvim-telescope/telescope-media-files.nvim'

  -- buffers
  use "kazhala/close-buffers.nvim"

  -- Treesitter. The run = "..." updates all our parsers.
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  -- autopairs for brace completion
  use "windwp/nvim-autopairs"
  use "p00f/nvim-ts-rainbow"

  -- Git integration
  use "lewis6991/gitsigns.nvim"

  -- nvim tree
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"

  -- nvim-R
  use {"jalvesaq/Nvim-R", branch = "stable", ft = {"r"}}

  -- vim-emmet for html
  -- use "mattn/emmet-vim"

  -- vim register stuff for registers
  -- use "vim-scripts/ReplaceWithRegister"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

---- Packer commands
-- :PackerStatus - shows us all our plugins
-- :PackerUpdate - updates our plugins
-- :PackerSync - update and compiles a file that packer uses to make things faster for us. 
-- :PackerInstall - installs the plugins you just wrote
