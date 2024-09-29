{
  inputs,
  lib,
  pkgs,
  username,
  ...
}: let
 # spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {

 imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

   home-manager.users.${username} = {
     home.packages = with pkgs; [
     spotify
    ];
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.Catppuccin;
    colorScheme = "mocha";

    enabledExtensions = with spicePkgs.extensions; [
      keyboardShortcut
      shuffle
    ];
  };
  };
}
