# CHANGES MADE - Switch to a new flake configuration.
{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      #url = "github:nix-community/home-manager"; Later if i want to update to the latest version i will just uncomment this
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    catppuccin.url = "github:catppuccin/nix";

    stylix.url = "github:danth/stylix"; # Dont need this for now
    nix-colors.url = "github:misterio77/nix-colors";

    ghostty = {
      url = "github:ghostty-org/ghostty";
    };

  };

  outputs =
    {
      self,
      home-manager,
      nixpkgs,
      catppuccin,
      nix-colors,
      ghostty,

      ...
    }@inputs:
    let
      inherit (self) outputs;
      #   inherit (import ./options.nix) username hostname;
      inherit (import ./options.nix);
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations = {
        "nixos" = nixpkgs.lib.nixosSystem {
          # Import the username and hostname from options after changing my flake config
          #        specialArgs = {inherit inputs outputs username hostna;};
          specialArgs = {
            inherit inputs outputs nix-colors;
          };
          modules = [
            { environment.systemPackages = [ ghostty.packages.x86_64-linux.default ]; }

            # ./hosts/m3-kratos
            catppuccin.nixosModules.catppuccin
            # stylix.nixosModules.stylix
            ./nixos/introvert

          ];
        };
      };
      homeConfigurations = {
        "introvert@nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
          #        extraSpecialArgs = {inherit inputs outputs username hostname;};
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [
            #./home/m3tam3re/m3tam3re.nix
            ./home-manager/introvert/nixos.nix
            ./home-manager/modules

            catppuccin.homeManagerModules.catppuccin
          ];
        };
      };
    };

  # outputs = inputs@{ self, nixpkgs, home-manager,catppuccin, spicetify-nix,stylix, ...} :
  #   let
  #     system = "x86_64-linux";
  #     inherit (import ./options.nix) username hostname;

  #     pkgs = import nixpkgs {
  #           inherit system;
  #           config = {
  #     	    allowUnfree = true;
  #           };
  #         };
  #    # pkgs = nixpkgs.legacyPackages.${system};
  #   in {

  #     nixosConfigurations = {
  #       "${hostname}"  = nixpkgs.lib.nixosSystem {
  #         specialArgs = { 
  #           inherit system; 
  #           inherit inputs; 
  #           inherit username; 
  #           inherit hostname;
  #           inherit pkgs;
  #         };
  #       modules = [
  #           catppuccin.nixosModules.catppuccin
  #           stylix.nixosModules.stylix
  #           ./nixos/configuration.nix
  #         ];
  #       };
  #     };

  #     homeConfigurations = {
  #        "${username}" = home-manager.lib.homeManagerConfiguration {
  #         inherit pkgs;
  #         modules = [
  #           catppuccin.homeManagerModules.catppuccin
  #           ./home-manager/home.nix
  #           ./home-manager/modules
  #         ];
  #         extraSpecialArgs = {
  #           inherit inputs; 
  #           inherit username;
  #         };
  #       };
  #     };
  #   };
}
