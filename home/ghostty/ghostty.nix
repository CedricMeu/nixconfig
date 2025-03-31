{ pkgs, config, ... }:
let
  ghostty_config = builtins.readFile ./config;
in
{
  home.file."${config.xdg.configHome}/ghostty/config" = {
    text =
      builtins.replaceStrings [ "ZELLIJ_PATH" ] [ "${pkgs.zellij.outPath}/bin/zellij" ]
        ghostty_config;
  };
}
