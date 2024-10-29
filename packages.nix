{ pkgs, pkgs-stable, ... }:
let
  ftn = pkgs.fortune.overrideAttrs (oldAttrs: {
    postInstall = ''
      mv $out/bin/fortune $out/bin/ftn
    '';
  });
in {
  home.packages = [
    pkgs.bashInteractive
    pkgs.bat
    pkgs.comma
    pkgs.coreutils
    pkgs-stable.elmPackages.elm
    pkgs-stable.elmPackages.elm-format
    pkgs-stable.elmPackages.elm-test
    pkgs.gnugrep
    pkgs.gnused
    pkgs.htop
    pkgs.jq
    pkgs.libiconv
    pkgs.nix-bash-completions
    pkgs.nixfmt-classic
    pkgs.nodePackages.prettier
    pkgs.nodePackages.typescript
    pkgs.nodejs
    pkgs.ripgrep
    pkgs.shadowenv
    pkgs.tree
    pkgs.watch
    pkgs.wget
    ftn
  ];
}
