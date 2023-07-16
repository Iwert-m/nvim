return {
  {
    "goolord/alpha-nvim",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        [[ __     __     __     ______     ______     ______      __   __   __     __    __    ]],
        [[/\ \   /\ \  _ \ \   /\  ___\   /\  == \   /\__  _\    /\ \ / /  /\ \   /\ \-./  \   ]],
        [[\ \ \  \ \ \/ \.\ \  \ \  __\   \ \  __<   \/_/\ \/    \ \ \./   \ \ \  \ \ \-./\ \  ]],
        [[ \ \_\  \ \__/\.~\_\  \ \_____\  \ \_\ \_\    \ \_\     \ \__|    \ \_\  \ \_\ \ \_\ ]],
        [[  \/_/   \/_/   \/_/   \/_____/   \/_/ /_/     \/_/      \/_/      \/_/   \/_/  \/_/ ]],
      }
      dashboard.section.buttons.val = {
        dashboard.button("p", " " .. " Projects", ":Telescope projects <CR>"),
        dashboard.button("s", " " .. " Restore Last Session", [[:lua require("persistence").load() <cr>]]),
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }
      return dashboard
    end,
  },
}
