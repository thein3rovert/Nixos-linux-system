# CHANGES MADE - Switch to a new flake configuration.
{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      #url = "github:nix-community/home-manager"; Later if i want to update to the latest version i will just uncomment this
      url = "github:nix-community/home-manager";
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

    # ADDED: Colmena input
    colmena.url = "github:zhaofengli/colmena";
    #
    # ghostty = {
    #   url = "github:ghostty-org/ghostty";
    # };

  };
  # REMEMBER TO BACKUP
  outputs =
    {
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
              # inherit overlays system;
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
          modules = [
            ./nixos/${host}
            self.inputs.home-manager.nixosModules.home-manager
            catppuccin.nixosModules.catppuccin
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
