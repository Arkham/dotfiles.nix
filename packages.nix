{ pkgs, pkgs-stable, ... }:
let
  ftn = pkgs.fortune.overrideAttrs (oldAttrs: {
    postInstall = ''
      mv $out/bin/fortune $out/bin/ftn
    '';
  });
in
{
  home.packages = [
    pkgs.bashInteractive
    pkgs.bat
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
    pkgs.nixfmt
    pkgs.nmap
    pkgs.pi-coding-agent
    pkgs.prettier
    pkgs.typescript
    pkgs.nodejs
    pkgs.shadowenv
    pkgs.tree
    pkgs.watch
    pkgs.wget
    ftn
  ];
}
