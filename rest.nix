{ ... }:
let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };
in {
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    defaultCommand = "rg --files --hidden --follow";
    defaultOptions = [ "-m --bind ctrl-a:select-all,ctrl-d:deselect-all" ];
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
      BAT_THEME = "OneHalfDark";
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

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    secureSocket = false;
    extraConfig = builtins.readFile ./tmux.conf;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  home.file.".inputrc".source = ./inputrc;
  home.file.".gemrc".text = "gem: --no-ri --no-rdoc";
}
