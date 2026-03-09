local wezterm = require 'wezterm'
local act = wezterm.action
local config = wezterm.config_builder()

-- Aesthetics (very important, we are not barbarians)
config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font('JetBrains Mono', { weight = 'Medium' })
config.font_size = 14.0
config.window_background_opacity = 0.95
config.macos_window_background_blur = 20

-- Tab bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false

-- Padding (breathing room is self care)
config.window_padding = { left = 12, right = 12, top = 8, bottom = 8 }

-- Multiplexing: workspaces per worktree
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 2000 }

config.keys = {
  -- New workspace (one per worktree/AI session)
  { key = 'w', mods = 'LEADER', action = act.PromptInputLine {
      description = 'Enter workspace name (e.g. feat/my-worktree)',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:perform_action(act.SwitchToWorkspace { name = line }, pane)
        end
      end),
  }},

  -- Switch workspaces
  { key = 'n', mods = 'LEADER', action = act.SwitchWorkspaceRelative(1) },
  { key = 'p', mods = 'LEADER', action = act.SwitchWorkspaceRelative(-1) },

  -- Workspace picker (like a save-select screen)
  { key = 's', mods = 'LEADER', action = act.ShowLauncherArgs { flags = 'WORKSPACES' } },

  -- Splits
  { key = '|', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = '-', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

  -- Pane navigation (hjkl because we live here now)
  { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
  { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },
  { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
  { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
}

-- Right status = current workspace name (so you always know where you are)
wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(wezterm.format({
    { Foreground = { AnsiColor = 'Fuchsia' } },
    { Text = '  ' .. window:active_workspace() .. '  ' },
  }))
end)

return config
