{ pkgs, ... }: {
  home.username = "arkham";
  home.homeDirectory =
    "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/arkham";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  imports = [ ./packages.nix ./vim.nix ./git.nix ./rest.nix ];
}
