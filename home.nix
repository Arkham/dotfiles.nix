{ lib, ... }:

let
  sources = import ./nix/sources.nix;
  niv = import sources.niv { };
  pkgs = import sources.nixpkgs { };
  pkgs-unstable = import sources.nixpkgs-unstable { };
in {
  home.username = "arkham";
  home.homeDirectory = "/Users/arkham";
  home.stateVersion = "21.11";
  programs.home-manager.enable = true;

  imports = [ ./packages.nix ./vim.nix ./git.nix ./rest.nix ];
}
