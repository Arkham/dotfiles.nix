{ lib, ... }:

let
  sources = import ./nix/sources.nix;
  niv = import sources.niv { };
  pkgs = import sources.nixpkgs { };
  pkgs-unstable = import sources.nixpkgs-unstable { };
in {
  home.packages = [
    niv.niv
    pkgs-unstable.comma
    pkgs-unstable.yarn
    pkgs.bashCompletion
    pkgs.bashInteractive
    pkgs.bat
    pkgs.coreutils
    pkgs.elmPackages.elm
    pkgs.elmPackages.elm-format
    pkgs.elmPackages.elm-test
    pkgs.fortune
    pkgs.gnused
    pkgs.htop
    pkgs.jq
    pkgs.libiconv
    pkgs.mosh
    pkgs.nix-bash-completions
    pkgs.nixfmt
    pkgs.nodejs-16_x
    pkgs.ripgrep
    pkgs.shadowenv
    pkgs.tree
    pkgs.watch
    pkgs.wget
  ];
}
