{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-stable, home-manager, nix-index-database, ... }:
    let
      withArch = arch:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${arch};
          modules = [ ./home.nix nix-index-database.hmModules.nix-index ];
          extraSpecialArgs = {
            pkgs-stable = nixpkgs-stable.legacyPackages.${arch};
          };
        };
    in {
      defaultPackage = {
        x86_64-darwin = home-manager.defaultPackage.x86_64-darwin;
        aarch64-darwin = home-manager.defaultPackage.aarch64-darwin;
        aarch64-linux = home-manager.defaultPackage.aarch64-linux;
      };

      homeConfigurations = {
        "arkham@metal" = withArch "aarch64-darwin";
        "arkham@mine" = withArch "x86_64-darwin";
        "arkham@iMuck" = withArch "x86_64-darwin";
        "arkham@pi" = withArch "aarch64-linux";
      };
    };
}
