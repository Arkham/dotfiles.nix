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
    pkgs.bash-completion
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
    pkgs.nodejs
    pkgs.nodePackages.typescript
    pkgs.ripgrep
    pkgs.shadowenv
    pkgs.tree
    pkgs.watch
    pkgs.wget
    pkgs.yarn
    pkgs.yt-dlp
  ];
}
