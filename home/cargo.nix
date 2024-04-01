{ config, ... }: {
  home.file."${config.home.homeDirectory}/.cargo/config.toml" =
    {
      source = ./cargo.toml;
    };
}
