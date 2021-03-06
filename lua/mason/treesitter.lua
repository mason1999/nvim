local status_ok, tree_sitter = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end


tree_sitter.setup {
  ensure_installed = "maintained", -- get all the languages which are "maintained" and will likely not break. You can also use the keyworkd "all" for all the languages you have installed.
  sync_install = false, -- install languages synchronously (only applied to 'ensure_installed')
  ignore_install = { "" }, -- List of parsers to ignore installing. E.g if you didn't want haskell or python to have treesitter syntax, we can ignore it here.
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true, -- enable additional vim regular expression highlighting.

  },
  indent = { enable = true, disable = { "yaml" } }, -- the indent really gets you wanna go. For example "cc" sometimes wont put you at the "right" indentation but tree sitter fixes that EXCEPT for yaml haha.
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}
