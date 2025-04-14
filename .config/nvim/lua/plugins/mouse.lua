return {
  {
    "nvzone/volt",
    commit = "c45d5f48da8e802e608b5c6da471ca4d84276dfb",
    lazy = true,
  },
  {
    "nvzone/menu",
    commit = "8adb036ec34c679050913864cbc98cc64eb91f6c",
    lazy = true,
    dependencies = {
      "nvzone/volt",
    },
    keys = {
      {"<RightMouse>", function()
        require("menu.utils").delete_old_menus()
        -- add more menus https://github.com/nvzone/menu
        -- https://github.com/nhattVim/MYnvim/blob/d3a5d5300e02249e533d3c20e7b0423b1557edd3/lua/plugins/nvzone/menu.lua#L6
        require("menu").open("default", { mouse = true })
      end},
    },
  },
}
