require "mason.options"
require "mason.keymaps"
require "mason.plugins"
require "mason.colorscheme"
require "mason.cmp"
require "mason.lsp" -- lsp is a directory. when we require a directory it sources the "init" file. So its like doing require "mason.lsp.init" with the "init.lua" being implied.  
