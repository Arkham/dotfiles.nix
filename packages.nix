{ pkgs, ... }: {
  home.packages = [
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
    pkgs.nix-bash-completions
    pkgs.nixfmt
    pkgs.nodePackages.prettier
    pkgs.nodePackages.typescript
    pkgs.nodejs
    pkgs.ripgrep
    pkgs.shadowenv
    pkgs.tree
    pkgs.watch
    pkgs.wget
  ];
}
