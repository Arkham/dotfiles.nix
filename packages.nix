{ lib, ... }:

let
  sources = import ./nix/sources.nix;
  niv = import sources.niv { };
  pkgs = import sources.nixpkgs { };
  pkgs-unstable = import sources.nixpkgs-unstable { };
in {
  home.packages = [
    niv.niv
    pkgs.bashCompletion
    pkgs.bashInteractive
    pkgs.bat
    pkgs.coreutils
    pkgs.fortune
    pkgs.gnused
    pkgs.htop
    pkgs.jq
    pkgs.libiconv
    pkgs.nix-bash-completions
    pkgs.nixfmt
    pkgs.ripgrep
    pkgs.tree
    pkgs.watch
    pkgs.wget
    pkgs.yarn
    pkgs-unstable.comma
  ];
}
