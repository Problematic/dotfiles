-- <C-h/j/k/l> move between nvim windows and tmux panes. The plugin's own edge
-- detection breaks inside floating windows (Snacks explorer/pickers), so the
-- mappings route through util.navigate, which handles that case geometrically.
--
-- g:tmux_navigator_no_mappings is required: the plugin installs its own
-- <C-h/j/k/l> mappings at load time, which would otherwise clobber the ones
-- lazy.nvim sets up from `keys` below. That also drops the plugin's terminal-mode
-- mappings, so `mode` re-adds them here.
local function nav(dir)
  return function()
    require("util.navigate").navigate(dir)
  end
end

local mode = { "n", "t" }

return {
  "christoomey/vim-tmux-navigator",
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  keys = {
    { "<c-h>", nav("h"), mode = mode, desc = "Go to left window/tmux pane" },
    { "<c-j>", nav("j"), mode = mode, desc = "Go to lower window/tmux pane" },
    { "<c-k>", nav("k"), mode = mode, desc = "Go to upper window/tmux pane" },
    { "<c-l>", nav("l"), mode = mode, desc = "Go to right window/tmux pane" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "Go to previous window/tmux pane" },
  },
}
