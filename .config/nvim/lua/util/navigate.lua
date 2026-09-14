-- Directional window navigation that also works from floating windows.
--
-- vim-tmux-navigator decides "am I at the edge of nvim?" by running `wincmd <dir>`
-- and checking whether winnr() changed. That test is meaningless inside a float:
-- floats are not in the window layout, so *any* directional wincmd leaves the
-- float for a normal window. The edge is never detected and tmux is never
-- signalled -- which is why <C-h> from the Snacks explorer (whose input/list are
-- floats anchored to a split box) landed in the main editor instead of the tmux
-- pane. For floats, decide geometrically instead.

local M = {}

local flag = { h = "L", j = "D", k = "U", l = "R" }

function M.tmux_select_pane(dir)
  if (vim.env.TMUX or "") == "" then
    return
  end
  local exe = vim.env.TMUX:match("tmate") and "tmate" or "tmux"
  local socket = vim.split(vim.env.TMUX, ",")[1]
  vim.fn.system({ exe, "-S", socket, "select-pane", "-t", vim.env.TMUX_PANE, "-" .. flag[dir] })
end

-- Nearest normal window in `dir` from `win`, or nil. `gap` is the distance to it
-- along the axis of travel; `off` breaks ties between stacked windows.
local function nearest(dir, win)
  local function box(w)
    local p = vim.fn.win_screenpos(w)
    return p[1], p[2], vim.api.nvim_win_get_height(w), vim.api.nvim_win_get_width(w)
  end
  local ar, ac, ah, aw = box(win)
  local best, score

  for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local cfg = vim.api.nvim_win_get_config(w)
    if w ~= win and cfg.relative == "" and cfg.focusable then
      local br, bc, bh, bw = box(w)
      local gap, off
      if dir == "h" then
        gap, off = ac - (bc + bw), math.abs((br + bh / 2) - (ar + ah / 2))
      elseif dir == "l" then
        gap, off = bc - (ac + aw), math.abs((br + bh / 2) - (ar + ah / 2))
      elseif dir == "k" then
        gap, off = ar - (br + bh), math.abs((bc + bw / 2) - (ac + aw / 2))
      else
        gap, off = br - (ar + ah), math.abs((bc + bw / 2) - (ac + aw / 2))
      end
      -- Allow a small overlap: a float may sit slightly over its neighbour.
      if gap >= -1 then
        local s = math.max(gap, 0) * 1000 + off
        if not score or s < score then
          best, score = w, s
        end
      end
    end
  end

  return best
end

--- @param dir "h"|"j"|"k"|"l"
function M.navigate(dir)
  local win = vim.api.nvim_get_current_win()

  if vim.api.nvim_win_get_config(win).relative == "" then
    -- Normal window: the plugin's own edge detection is correct here.
    vim.cmd("TmuxNavigate" .. ({ h = "Left", j = "Down", k = "Up", l = "Right" })[dir])
  else
    local target = nearest(dir, win)
    if target then
      vim.api.nvim_set_current_win(target)
    else
      M.tmux_select_pane(dir)
    end
  end
end

return M
