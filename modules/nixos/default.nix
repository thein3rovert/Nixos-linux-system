{ lib, config, ... }:
let
  cfg = config.nixosSetup;
in
{
  options.nixosSetup = {
    enable = lib.mkEnableOption "My nixos program services and configuration variables";
    name = lib.mkOption {
      default = null;
      type = lib.types.str;
      description = ''Name of programs'';
    };

    group = lib.mkOption {
      default = "introvert";
      type = lib.types.str;
      description = ''
        Group to run my programs as
      '';
    };
  };
  imports = [
    ./podman
    ./obs-studio
    ./services
    ./uxplay
  ];
}
