{ pkgs, ... }:
let
  goldenview = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "goldenview";
    src = pkgs.fetchFromGitHub {
      owner = "zhaocai";
      repo = "GoldenView.Vim";
      rev = "ac0ee3014caa36c52e8352d11c308b27a159113c";
      sha256 = "1gzp81spsbg20svwd14rixhgl39ir458p5k9q5jjv9l5rbnbinad";
    };
  };

  shadowenv = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "shadowenv";
    src = pkgs.fetchFromGitHub {
      owner = "Arkham";
      repo = "shadowenv.vim";
      rev = "6422c3a651c3788881d01556cb2a90bdff7bf002";
      sha256 = "1lfckdxkd9cl0bagcxwfg0gb84bs2sxxscrwd86yrqyhrvm24hik";
    };
  };

  vim-yoink = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "vim-yoink";
    src = pkgs.fetchFromGitHub {
      owner = "svermeulen";
      repo = "vim-yoink";
      rev = "89ed6934679fdbc3c20f552b50b1f869f624cd22";
      sha256 = "0r8m43lkc1a7n0bkp1xfn9n3n44n8vsdvzz908ma6xg6ihwqlhbs";
    };
  };
in {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    plugins = with pkgs.vimPlugins; [
      ale
      fzf-vim
      goldenview
      lightline-vim
      neoformat
      quickfix-reflector-vim
      shadowenv
      splitjoin-vim
      supertab
      tabular
      vim-abolish
      vim-commentary
      vim-endwise
      vim-eunuch
      vim-fugitive
      vim-gruvbox8
      vim-mundo
      vim-polyglot
      vim-rails
      vim-repeat
      vim-rhubarb
      vim-surround
      vim-test
      vim-tmux-navigator
      vim-unimpaired
      vim-visualstar
      vim-yoink
      vimux
    ];
    extraConfig = builtins.readFile ./vimrc;
  };
}
