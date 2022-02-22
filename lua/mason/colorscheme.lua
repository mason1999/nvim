-- vim.cmd "colorscheme system76" <-- what we have below is bascially this, but with more protections. 

-- the colorscheme which we want
local colorscheme = "darkplus"

-- we use a protected call to call the vim.cmd with the concatenation operator. If the command works, then it'll change it. If it doesnt (status_ok = false) then we go into the if statement
-- the underscore "_" is there because we don't care about the second argument. There are some cases in lua where we do care about the second argument, and so we would assign it to a variable. In this case we didn't
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
