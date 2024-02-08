# Nix Darwin Kickstarter - Rich Demo

 An extensive demo featuring a plethora of configurations that can serve as a reference for your setup. However, exercise caution, as it may **OVERWRITE** your system configuration. **DO NOT** deploy it directly to your system.


## How to Start

1. Start your nix-darwin journey by following the [minimal](../minimal) configuration.
2. Read all the files in this repository, and understand what they do.
   1. If you have trouble understanding, [ryan4yin/nixos-and-flakes-book](https://github.com/ryan4yin/nixos-and-flakes-book) is a good resource to learn nix and flakes.
3. Copy and CUSTOMIZE the configuration you need from this demo to your own configuration.
4. Run `make deploy` in the root of your nix configuration to deploy your configuration.

## Configuration Structure

Your current nix-darwin configuration's structure should be as follows:

```bash
› tree
.
├── flake.lock  # a lock file generated by nix, you can ignore it for now
├── flake.nix   # the entry point of your nix configuration, you need to add your hostname here
├── home        # home-manager's configuration folder, help you manage your dotfiles & user-level apps.
│   ├── shell.nix     # customize zsh's dotfiles
│   ├── core.nix     # user-level apps from nixpkgs(nix's official package repository)
│   ├── default.nix  # home-manager's entry point, you need to import all other nix files in home folder here.
│   ├── git.nix      # customize git's dotfiles
│   └── starship.nix  # customize starship's dotfiles
├── Makefile    # a Makefile to simplify your nix-darwin workflow.
├── README.md
├── modules     # a folder contains all your nix-darwin configuration files
│   ├── apps.nix        # contains all your homebrew & nix apps(both GUI & CLI)
│   ├── host-users.nix  # defines your hostname & all your system users
│   ├── nix-core.nix    # nix's core configuration, you can ignore it for now
│   └── system.nix      # defines your macOS's system configuration(like dock, trackpad, keyboard, finder, loginwindow, etc.)
└── scripts
    └── darwin_set_proxy.py  # a script to set http proxy for nix & homebrew.
```

## Notes on Network Proxy

If you are in a network environment that requires proxy(such as China), you may need to set up proxy for nix and homebrew.

Related files:

- [rich-demo/scripts/darwin_set_proxy.py](/rich-demo/scripts/darwin_set_proxy.py)
- [rich-demo/Justfile](/rich-demo/Justfile)
- [rich-demo - homebrew's mirror settings](/rich-demo/modules/homebrew-mirror.nix)
