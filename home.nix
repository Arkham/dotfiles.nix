{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.ag
    pkgs.bashCompletion
    pkgs.bashInteractive
    pkgs.coreutils
    pkgs.direnv
    pkgs.git
    pkgs.htop
    pkgs.nixfmt
    pkgs.reattach-to-user-namespace
  ];

  programs.git = {
    enable = true;
    userName = "Ju Liu";
    userEmail = "ju@noredink.com";
    aliases = {
      ci = "commit";
      co = "checkout";
      di = "diff";
      dc = "diff --cached";
      addp = "add -p";
      shoe = "show";
      st = "status";
      unch = "checkout --";
      br = "checkout";
      bra = "branch -a";
      newbr = "checkout -b";
      rmbr = "branch -d";
      mvbr = "branch -m";
      cleanbr = "!git remote prune origin && git co master && git branch --merged | grep -v '\*' | xargs -n 1 git branch -d && git co -";
      as = "update-index --assume-unchanged";
      nas = "update-index --no-assume-unchanged";
      al = "!git config --get-regexp 'alias.*' | colrm 1 6 | sed 's/[ ]/ = /'";
    };
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    defaultCommand = "ag -g ''";
  };

  programs.bash = {
    enable = true;
    profileExtra = ''
      . "$HOME/.nix-profile/etc/profile.d/nix.sh"
      . "$HOME/.nix-profile/etc/profile.d/bash_completion.sh"
      . "$HOME/.nix-profile/etc/bash_completion.d/git-prompt.sh"
    '';
    historyControl = [ "ignorespace" "ignoredups" ];
    sessionVariables = {
      PROMPT_COMMAND = "echo";
      EDITOR = "nvim";
      ERL_AFLAGS = "-kernel shell_history enabled";
    };
    shellAliases = {
      ls = "ls -hF --color";
      la = "ls -lA";
      rm = "rm -i";
      mv = "mv -i";
      cp = "cp -i";
      im = "vim";
      grep = "grep --color=auto";
      sudo = "sudo ";
    };
    shellOptions = [
      "cdspell"
      "checkwinsize"
      "cmdhist"
      "dotglob"
      "histappend"
      "nocaseglob"
    ];
    initExtra = builtins.readFile ./bashrc;
  };

  programs.neovim = { enable = true; };

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    extraConfig = builtins.readFile ./tmux.conf;
  };
}
