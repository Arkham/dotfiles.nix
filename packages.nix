{ lib, ... }:

let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };
  pkgs-unstable = import sources.nixpkgs-unstable { };
in {
  home.packages = [
    pkgs-unstable.comma
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
    pkgs.nix-bash-completions
    pkgs.nixfmt
    pkgs.niv
    pkgs.nodejs
    pkgs.ripgrep
    pkgs.shadowenv
    pkgs.tree
    pkgs.watch
    pkgs.wget
    pkgs.yarn
  ];
}
