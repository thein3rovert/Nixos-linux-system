{
  config,
  lib,
  pkgs,
  ...
}:
let
  service = "podman";
  pg = config.nixosSetup;
  cfg = pg.programs.${service};
in
{
  # Handled and managed by nixos services
  options.nixosSetup.programs.${service}.enable = lib.mkEnableOption {

    description = "Enable ${service} container runtime";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = lib.optionals config.services.xserver.enable [ pkgs.pods ];

    virtualisation = {
      oci-containers = {
        backend = "${service}";
      };
      # Try sting interpolation for podman later
      podman = {
        enable = true;
        autoPrune.enable = true;
        defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
        # dockerCompat = true;
      };
    };

    users.users.introvert.extraGroups = [ "docker" ];
  };
}
