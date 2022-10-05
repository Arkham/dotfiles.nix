{ lib, ... }:
let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };

  vimSources =
    lib.filterAttrs (_: source: lib.hasAttrByPath [ "vim" ] source) sources;

  vimUnpatched = lib.mapAttrs (name: source:
    pkgs.vimUtils.buildVimPluginFrom2Nix {
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

    "vim-polyglot" = vimUnpatched.vim-polyglot.overrideAttrs (attrs: {
      # don't run the Makefile
      buildPhase = "true";
    });
  };
in {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    plugins = (lib.mapAttrsToList (_: plugin: plugin) vimPlugins)
      ++ [ pkgs.vimPlugins.fzf-vim ];
    extraConfig = builtins.readFile ./vimrc;
  };
}
