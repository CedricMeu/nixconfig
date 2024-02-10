{
  programs.kitty = {
    enable = true;

    shellIntegration.enableZshIntegration = true;

    theme = "Catppuccin-Macchiato";

    font = {
      name = "Monoid Nerd Font Mono";
      size = 10;
    };

    settings = {
      enable_audio_bell = false;
      undercurl_style = "thick-sparse";
      tab_title_template = "[{index}] {fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}";

      macos_option_as_alt = "left";
      macos_quit_when_last_window_closed = "yes";
    };

    keybindings = {
      "kitty_mod+enter" = "new_window_with_cwd";
      "cmd+enter" = "new_window_with_cwd";
    };
  };
}
