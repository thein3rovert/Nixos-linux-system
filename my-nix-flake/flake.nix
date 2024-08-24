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

   # stylix.url = "github:danth/stylix"; Dont need this for now
    
  };


  outputs = inputs@{ self, nixpkgs, home-manager,catppuccin, ...} :
    let
      system = "x86_64-linux";
      inherit (import ./options.nix) username hostname;

      pkgs = import nixpkgs {
            inherit system;
            config = {
      	    allowUnfree = true;
            };
          };
     # pkgs = nixpkgs.legacyPackages.${system};
    in {

      nixosConfigurations = {
        "${hostname}"  = nixpkgs.lib.nixosSystem {
          specialArgs = { 
            inherit system; 
            inherit inputs; 
            inherit username; 
            inherit hostname;
            inherit pkgs;
          };
        modules = [
            catppuccin.nixosModules.catppuccin
            ./nixos/configuration.nix
          ];
        };
      };

      
      homeConfigurations = {
         "${username}" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            catppuccin.homeManagerModules.catppuccin
            ./home-manager/home.nix
            ./home-manager/modules
          ];
          extraSpecialArgs = {
            inherit inputs; 
            inherit username;
          };
        };
      };
    };
}

