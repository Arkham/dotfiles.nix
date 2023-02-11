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
      config = system: {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [ ./home.nix nix-index-database.hmModules.nix-index ];
      };
    in {
      defaultPackage.x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;
      defaultPackage.aarch64-darwin =
        home-manager.defaultPackage.aarch64-darwin;

      homeConfigurations."arkham@mine" =
        home-manager.lib.homeManagerConfiguration (config "x86_64-darwin");

      homeConfigurations."arkham@metal" =
        home-manager.lib.homeManagerConfiguration (config "aarch64-darwin");
    };
}
