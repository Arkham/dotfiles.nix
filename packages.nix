{ lib, ... }:

let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { };
  # pkgs-unstable = import sources.nixpkgs-unstable { };
in {
  home.packages = [
    pkgs.bash-completion
    pkgs.bashInteractive
    pkgs.bat
    pkgs.comma
    pkgs.coreutils
    pkgs.elmPackages.elm
    pkgs.elmPackages.elm-format
    pkgs.elmPackages.elm-test
    pkgs.fortune
    pkgs.gnused
    pkgs.htop
    pkgs.jq
    pkgs.libiconv
    pkgs.niv
    pkgs.nix-bash-completions
    pkgs.nixfmt
    pkgs.nodePackages.typescript
    pkgs.nodejs
    pkgs.ripgrep
    pkgs.shadowenv
    pkgs.tree
    pkgs.watch
    pkgs.wget
    pkgs.yt-dlp
  ];
}
