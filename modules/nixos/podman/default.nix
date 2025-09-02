{
  config,
  lib,
  pkgs,
  ...
}:
let
  # INFO: This config idea was taken from @notthebee config
  # https://github.com/notthebee/nix-config/blob/main/homelab/services/miniflux/default.nix
  service = "podman";
  pg = config.nixosSetup; # Check default options in .. dir
  cfg = pg.programs.${service};
in
{
  # Handled and managed by nixos services
  options.nixosSetup.programs.${service} = {
    enable = lib.mkEnableOption {
      description = "Enable ${service} container runtime";
    };
    programGroup = lib.mkOption {
      type = lib.types.str;
      default = "${pg.group}";
    };

  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = lib.optionals config.services.xserver.enable [ pkgs.pods ];

    virtualisation = {
      oci-containers = {
        backend = "${service}";
      };
      ${service} = {
        enable = true;
        autoPrune.enable = true;
        defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
        # dockerCompat = true;
      };
    };

    users.users."${cfg.programGroup}".extraGroups = [ "docker" ];
  };
}
