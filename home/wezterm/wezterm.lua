local wezterm = require 'wezterm'

return {
  enable_tab_bar = false,
  disable_default_key_bindings = true,
  keys = {
    {
      key = 'c',
      mods = 'CMD',
      action = wezterm.action.CopyTo 'Clipboard',
    },
    {
      key = 'v',
      mods = 'CMD',
      action = wezterm.action.PasteFrom 'Clipboard',
    },
    {
      key = 'q',
      mods = 'CMD',
      action = wezterm.action.QuitApplication,
    },
    {
      key = '+',
      mods = 'CMD',
      action = wezterm.action.IncreaseFontSize,
    },
    {
      key = '-',
      mods = 'CMD',
      action = wezterm.action.DecreaseFontSize,
    },
    {
      key = '0',
      mods = 'CMD',
      action = wezterm.action.ResetFontSize,
    },
    {
      key = 'm',
      mods = 'CMD',
      action = wezterm.action.Hide,
    },
  },
  adjust_window_size_when_changing_font_size = false,

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  window_decorations = 'RESIZE',
  color_scheme = 'Catppuccin Latte',

  font = wezterm.font('CaskaydiaCove Nerd Font Mono', { weight = 'Regular', italic = false }),
  font_size = 12,

  default_prog = { 'ZELLIJ_PATH', '-l', 'welcome'},
}
