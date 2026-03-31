{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    settings = {
      # format = "$directory$git_branch$git_commit$git_state$git_metrics$git_status\n$character";
      format = "$directory$\{custom.jj\}\n$character";
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
        jj = {
          when = "jj-starship detect";
          command = "jj-starship --git-symbol \"󰊢 \" --jj-symbol \"󱗆 \"";
          format = "$output ";
        };
      };
    };
  };
}
