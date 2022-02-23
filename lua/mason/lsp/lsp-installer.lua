-- we do a protected call to require the nvim-lsp-installer plugin. If it doesnt' work then don't continue with this file and just return 
local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

-- All the following code comes from the actual nvim-lsp-installer plugin on github we just copied and pasted it. 
-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server) -- <-- an anonymous function 
  
  -- we pass some options (basically functions)
  -- handlers, on_attach function and capabilites are found in handlers.lua. So go to there to see the source code
	local opts = {
		on_attach = require("mason.lsp.handlers").on_attach, -- what happens to language servers on attach
		capabilities = require("mason.lsp.handlers").capabilities, --  some capabilities
	}

  -- note how we passed the options to each server. We get these names for LspInstall 
  -- each time we extend the opts variable
	 if server.name == "jsonls" then
	 	local jsonls_opts = require("mason.lsp.settings.jsonls")
	 	opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	 end

	 if server.name == "sumneko_lua" then
	 	local sumneko_opts = require("mason.lsp.settings.sumneko_lua")
	 	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	 end

	 if server.name == "pyright" then
	 	local pyright_opts = require("mason.lsp.settings.pyright")
	 	opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	 end

   -- TODO: go to settings and modify java settings if necessary
	 -- if server.name == "jdtls" then
	 -- 	local jdtls_opts = require("mason.lsp.settings.jdtls")
	 -- 	opts = vim.tbl_deep_extend("force", jdtls_opts, opts)
	 -- end

  -- setup the server with the opts variable we made
	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)
