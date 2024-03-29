require("tabby.tabline").use_preset("active_wins_at_tail", {
  theme = {
    fill = "TabLineFill", -- tabline background
    head = "TabLine", -- head element highlight
    current_tab = "TabLineSel", -- current tab label highlight
    tab = "TabLine", -- other tab label highlight
    win = "TabLine", -- window highlight
    tail = "TabLine", -- tail element highlight
  },
  tab_name = {
    name_fallback = "function({tabid}), return a string",
  },
  buf_name = {
    mode = "'unique'|'relative'|'tail'|'shorten'",
  },
})
