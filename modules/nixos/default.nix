{ lib, config, ... }:
let
  cfg = config.nixosSetup;
in
{
  options.program = {
    enable = lib.mkEnableOption "My nixos program services and configuration variables";
    name = lib.mkOption {
      default = null;
      type = lib.types.str;
      description = ''Name of programs'';
    };
  };
  imports = [
    ./podman
    ./obs-studio
  ];
}
