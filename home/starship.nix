{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    settings = {
      format = "$directory$git_branch$git_commit$git_state$git_metrics$git_status$character";
      right_format = "$all\${custom.systime}";
      username = {
        # style_user = "blue bold";
        # style_root = "red bold";
        # format = "[$user]($style) ";
        # show_always = true;
        disabled = true;
      };
      hostname = {
        # ssh_only = false;
        # ssh_symbol = "🌐 ";
        # format = "on [$hostname](bold red) ";
        # trim_at = ".local";
        disabled = true;
      };
      gcloud = {
        disabled = true;
      };
      custom = {
        systime = {
          shell = [ "nu" "-c" ];
          command = "date now | format date \"%y/%m/%d %H:%M:%S\"";
          format = "\\([$output]($style)\\)";
          when = true;
        };
      };
    };
  };
}
