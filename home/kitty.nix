{ pkgs, ... }: {
  programs.kitty = {
    enable = false;

    # shellIntegration.enableZshIntegration = true;

    themeFile = "Catppuccin-Latte";

    font = {
      # name = "JetBrainsMono Nerd Font Mono";
      name = "CaskaydiaCove Nerd Font Mono";
      size = 12;
    };

    settings = {
      shell = "${pkgs.zellij.outPath}/bin/zellij -l welcome";
      enable_audio_bell = false;
      undercurl_style = "thick-sparse";
      tab_title_template = "[{index}] {fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{title}";

      macos_option_as_alt = "left";
      macos_quit_when_last_window_closed = "yes";
    };

    keybindings = {
      "kitty_mod+enter" = "no_op";
      "cmd+enter" = "no_op";
      "kitty_mod+t" = "no_op";
      "cmd+t" = "no_op";
      # "kitty_mod+enter" = "new_window_with_cwd";
      # "cmd+enter" = "new_window_with_cwd";
    };
  };
}
