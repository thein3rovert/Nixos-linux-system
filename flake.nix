# CHANGES MADE - Switch to a new flake configuration.
{
  description = "This is a configuration for managing multiple nixos machines";

  inputs = {

    agenix.url = "github:ryantm/agenix";

    catppuccin.url = "github:catppuccin/nix";

    colmena.url = "github:zhaofengli/colmena";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    stylix.url = "github:danth/stylix";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    # ghostty = {
    #   url = "github:ghostty-org/ghostty";
    # };

  };
  # REMEMBER TO BACKUP
  outputs =
    {
      agenix,
      self,
      home-manager,
      nixpkgs,
      catppuccin,
      nix-colors,
      colmena,
      # ghostty,

      ...
    }@inputs:
    let
      inherit (self) outputs;
      allSystems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      forAllSystems =
        f:
        self.inputs.nixpkgs.lib.genAttrs allSystems (
          system:
          f {
            pkgs = import self.inputs.nixpkgs {
              inherit
                # overlays
                system
                ;
              config.allowUnfree = true;
            };
          }
        );

      forAllLinuxHosts = self.inputs.nixpkgs.lib.genAttrs [
        "nixos"
      ];
    in
    {
      overlays = import ./overlays { inherit inputs; };

      nixosConfigurations = forAllLinuxHosts (
        host:
        self.inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit
              self
              inputs
              nix-colors
              ;
          };

          # === Modules ===
          modules = [
            ./nixos/${host}
            agenix.nixosModules.default
            catppuccin.nixosModules.catppuccin
            self.inputs.home-manager.nixosModules.home-manager

            # === Custom Modules ===
            self.nixosModules.nixosOs
            {
              home-manager = {
                backupFileExtension = "backup";
                extraSpecialArgs = { inherit self; };
                useGlobalPkgs = true;
                useUserPackages = true;
              };
              nixpkgs = {
                # inherit overlays;
                config.allowUnfree = true;
              };
            }
          ];
        }
      );

      # === Nixos Custom Modules ===
      nixosModules = {
        nixosOs = ./modules/nixos;
      };

      # -------------------------------
      # DEPLOYMENT
      # --------------------------------

      # ADDED: New colmenaHive output
      colmenaHive = colmena.lib.makeHive self.outputs.colmena;

      colmena = {
        meta = {
          nixpkgs = import nixpkgs {
            system = "x86_64-linux";
          };
        };
      };
    };
}
