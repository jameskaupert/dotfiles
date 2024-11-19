return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
        {
          section = "terminal",
          cmd = "pokemon-colorscripts -r -b --no-title; sleep .1",
          random = 10,
          pane = 2,
          indent = 4,
          height = 30,
        },
}
    },
    statuscolumn = { enabled = true },
  },
}
