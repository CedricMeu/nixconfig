{ config, ... }:
{
  home.file."${config.home.homeDirectory}/.npmrc" = {
    text = ''
      prefix = ''${HOME}/.cache/npm
      color=true
    '';
  };
}
