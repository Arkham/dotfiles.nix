{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, nix-index-database, ... }:
    let
      system = "x86_64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      defaultPackage.${system} = home-manager.defaultPackage.${system};

      homeConfigurations.arkham = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ ./home.nix nix-index-database.hmModules.nix-index ];
      };
    };
}
