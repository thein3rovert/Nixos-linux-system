{
  self,
  inputs,
  lib,
  config,
  ...
}:
{
  home-manager.users.introvert =
    { pkgs, ... }:
    {
      imports = [
        # INFO: THESE HAVENT BE CREATED YET, they should first be created in the flake before import
        # self.homeManagerModules.default
        # self.inputs.agenix.homeManagerModules.default
        ../../home-manager/apps
        ../../home-manager/modules
      ];

      home = {
        homeDirectory = "/home/introvert";

        packages = with pkgs; [
          btop
        ];

        stateVersion = "24.11";
        username = "introvert";
      };
      programs = {
        # helix = {
        #   enable = true;
        #   defaultEditor = true;
        # };

        home-manager.enable = true;
      };

      apps = {
        cli = {
          zsh.enable = true;
          fzf.enable = false;
        };
      };

      ########
      # WAYBAR
      ########
      programs.waybar = {
        enable = true;
      };

      nix = {
        package = lib.mkDefault pkgs.nix;
        settings = {
          experimental-features = [
            "nix-command"
            "flakes"
            #"repl-flake"
          ];
          warn-dirty = false;
        };
      };
    };
}
