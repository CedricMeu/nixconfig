{ lib
, useremail
, ...
}: {
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  #
  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
    rm -f ~/.gitconfig
  '';

  programs.git = {
    enable = true;
    lfs.enable = true;

    # TODO replace with your own name & email
    userName = "CedricMeu";
    userEmail = useremail;

    includes = [
      {
        # use diffrent email & name for work
        path = "~/work/.gitconfig";
        condition = "gitdir:~/work/";
      }
    ];

    ignores = [
      # Vim/Emacs
      "*~"
      ".*.swp"

      # Mac
      ".DS_Store"
      ".fseventsd"
      ".Spotlight-V100"
      ".TemporaryItems"
      ".Trashes"

      # Helix
      ".helix/"

      # VSCode Workspace Folder
      ".vscode/"

      # direnv
      ".direnv"
      ".envrc"
    ];

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
    };

    delta = {
      enable = true;
      options = {
        features = "side-by-side";
        navigate = true;
        light = false;
        syntax-theme = "catppuccin";
      };
    };

    aliases = {
      # common aliases
      br = "branch";
      co = "checkout";
      st = "status";
      ls = "log --pretty=format:\"%C(yellow)%h%Cred%d : %Creset%s%Cblue [%cn]\" --decorate";
      tree = "log --pretty=format:\"%C(yellow)%h%Cred%d : %Creset%s%Cblue [%cn]\" --decorate --graph --abbrev-commit --all";
      ll = "log --pretty=format:\"%C(yellow)%h%Cred%d : %Creset%s%Cblue [%cn]\" --decorate --numstat";
      cm = "commit -m";
      ca = "commit -am";
      dc = "diff --cached";
      amend = "commit --amend -m";

      # aliases for submodule
      update = "submodule update --init --recursive";
      foreach = "submodule foreach";
    };
  };
}
