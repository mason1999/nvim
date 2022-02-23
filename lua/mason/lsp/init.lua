-- do a protected call to lspconfig (in our plugins file). We require the plugin. If it doesn't exist, then don't do anything to setup LSP
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

-- we now require the two other files in the same directory
require("mason.lsp.lsp-installer")
require("mason.lsp.handlers").setup()
