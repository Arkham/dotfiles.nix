{ pkgs, lib, ... }:

let
  sources = import ./nix/sources.nix;
  niv = import sources.niv { };

  vimSources =
    lib.filterAttrs (_: source: lib.hasAttrByPath [ "vim" ] source) sources;

  vimUnpatched = lib.mapAttrs (name: source:
    pkgs.vimUtils.buildVimPlugin {
      name = name;
      src = source;
    }) vimSources;

  vimPlugins = vimUnpatched // {
    "supertab" = vimUnpatched.supertab.overrideAttrs (attrs: {
      # don't run the Makefile
      buildPhase = "true";
    });

    "ultisnips" = vimUnpatched.ultisnips.overrideAttrs (attrs: {
      # don't run the Makefile
      buildPhase = "true";
    });
  };
in {
  programs.home-manager.enable = true;

  home.packages = [
    niv.niv
    pkgs.ag
    pkgs.bashCompletion
    pkgs.bashInteractive
    pkgs.coreutils
    pkgs.direnv
    pkgs.elmPackages.elm
    pkgs.elmPackages.elm-format
    pkgs.elmPackages.elm-test
    pkgs.fortune
    pkgs.git
    pkgs.git-lfs
    pkgs.haskellPackages.hindent
    pkgs.htop
    pkgs.jq
    pkgs.nix-bash-completions
    pkgs.nixfmt
    pkgs.nodejs
    pkgs.reattach-to-user-namespace
    pkgs.stack
    pkgs.tree
    pkgs.watch
    pkgs.youtube-dl
  ];

  programs.git = {
    enable = true;
    userName = "Ju Liu";
    userEmail = "ju@noredink.com";
    ignores = [ "*~" "tags" ".env" ".DS_Store" ];
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
      cleanbr =
        "!git remote prune origin && git co master && git branch --merged | grep -v '*' | xargs -n 1 git branch -d && git co -";
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
    profileExtra = builtins.readFile ./profile;
    historyControl = [ "ignorespace" "ignoredups" ];
    sessionVariables = {
      PROMPT_COMMAND = "echo";
      EDITOR = "nvim";
      RUBY_CONFIGURE_OPTS = "--disable-install-doc";
      ERL_AFLAGS = "-kernel shell_history enabled";
      SHELL = "${pkgs.bashInteractive}/bin/bash";
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

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = (lib.mapAttrsToList (_: plugin: plugin) vimPlugins)
      ++ [ pkgs.fzf ];
    extraConfig = builtins.readFile ./vimrc;
  };

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    secureSocket = false;
    extraConfig = builtins.readFile ./tmux.conf;
  };

  home.file.".inputrc".source = ./inputrc;
  home.file.".gemrc".text = "gem: --no-ri --no-rdoc";
  home.file.".direnvrc".source = ./direnvrc;
}
