{ lib, config, ... }:
let
  cfg = config.nixosSetup.services;
in
{
  # TODO: Add a submodule for type Podman services and Nixos services
  options.nixosSetup.services = {
    enable = lib.mkEnableOption "My nixos services config varibles";

    linkdingName = lib.mkOption {
      default = "linkding";
      type = lib.types.str;
      description = ''linkding service '';
    };
  };
  imports = [ ./linkding ];
}
