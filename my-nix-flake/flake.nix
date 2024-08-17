{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
    
  };
  outputs = { self, nixpkgs, home-manager,catppuccin, ...} :
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        nixos  = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
            catppuccin.nixosModules.catppuccin
            ./nixos/configuration.nix
          ];
        };
      };
      homeConfigurations = {
         introvert= home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            catppuccin.homeManagerModules.catppuccin
            ./home-manager/home.nix
            ./home-manager/modules
          ];
        };
      };
    };
}

