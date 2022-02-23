-- requrie the cmp plugin. This is basically the same as local cmp = require "cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  return
end

-- require the luasnip plugin
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
end

-- require the "like vscode" plugins. It makes sure all our snippets work
require("luasnip/loaders/from_vscode").lazy_load()

-- Helps our supertab work better. 
local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

-- There icons are from a nerdfont. 
--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

-- setting up nvim cmp 
-- we basically compied this from the plugin github, except we chose luasnip
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(), -- move throughout the menu with ctrl-k. Like ctrl-n 
		["<C-j>"] = cmp.mapping.select_next_item(), -- move throughout the menu with ctrl-j. Like ctrl-p
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- if you don't wanna type for the completions, type ctrl-space
    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ["<C-e>"] = cmp.mapping { -- get rid of completions with ctrl-e
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ["<CR>"] = cmp.mapping.confirm { select = true }, -- select selection by hitting enter

    -- supertabbing 
    ["<Tab>"] = cmp.mapping(function(fallback) -- using tab as super tab. 
      if cmp.visible() then
        cmp.select_next_item() -- if the menu is visible then select the next item 
      elseif luasnip.expandable() then
        luasnip.expand() -- elseif I have the ability to exapnd a luasnippet, then tab expands the luas snippet
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump() -- elseif the snippet is exapandable or jumpable, then we jump to the next thing
      elseif check_backspace() then
        fallback() -- elseif just use the normal tabbing 
      else
        fallback() -- else just use the normal tabbing
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  }, -- end supertabbing 

  
  -- formatting is how does the completin menu LOOK. right now we have "kind"-"abbreviation"-"menu" where
  -- (1) kind is just a symbol
  -- (2) abbr is an abbreviation of the autocompletion
  -- (3) menu tells you where the completion comes from
  -- move the things around in the table to rearrange the order. for example: {"menu", "abbr", "kind"}
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      -- Kind icons
      -- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        nvim_lua = "[NVIM_LUA]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]",
      })[entry.source.name]
      return vim_item
    end,
  },
  -- the order of precedence. This means that the luasnip stuff will show up first as opposed to the file stuff
  sources = {
    { name = "nvim_lsp"},
    { name = "nvim_lua"},
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  -- the documentation box which shows up could also just set it equal to true for it to show up. 
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
  experimental = {
    ghost_text = false, -- ghost text is just literally does faded "ghost text"
    native_menu = false,
  },
}
