-- Setup nvim-cmp.
local status_ok, nvimr = pcall(require, "Nvim-R")
if not status_ok then
  --vim.notify("Nvim-R plug couldn't be found")
  return
end
