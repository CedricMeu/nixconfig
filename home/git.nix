{
  lib,
  useremail,
  ...
}:
{
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  #
  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
    rm -f ~/.gitconfig
  '';

  programs = {
    difftastic = {
      enable = true;
      git.enable = true;
      git.diffToolMode = true;
    };

    delta = {
      enable = false;
      options = {
        # features = "side-by-side";
        navigate = true;
        light = false;
        syntax-theme = "catppuccin";
      };
    };

    git = {
      enable = true;
      lfs.enable = true;

      includes = [
        {
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

        # direnv
        ".direnv"
        ".envrc"

        # go
        "__debug*"
      ];

      settings = {
        user = {
          name = "CedricMeu";
          email = useremail;
        };

        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        pull.rebase = true;

        alias = {
          # common aliases
          br = "branch";
          co = "checkout";
          st = "status";
          ls = "log --pretty=format:\"%C(yellow)%h%Cred%d : %Creset%s%Cblue [%cn]\" --decorate";
          tree = "log --pretty=format:\"%C(yellow)%h%Cred%d : %Creset%s%Cblue [%cn]\" --decorate --graph --abbrev-commit --all";
          ll = "log --pretty=format:\"%C(yellow)%h%Cred%d : %Creset%s%Cblue [%cn]\" --decorate --numstat";
          c = "commit";
          cm = "commit -m";
          ca = "commit --amend";
          cam = "commit --amend --message";
          cr = "commit --reuse-message=ORIGIN_HEAD";
          r = "rebase --update-refs -i";
          # diff = "diff|delta"; # A hack to make mouse input work on git diff with delta
          dc = "diff --cached";
        };
      };
    };
  };
}
