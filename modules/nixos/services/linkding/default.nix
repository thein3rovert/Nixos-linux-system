{ config, lib, ... }:
let
  #service = "${srv.linkding}";
  service = "linkding";
  srv = config.nixosSetup.services;
  cfg = srv.${service};
in
{
  options.nixosSetup.services.${service} = {
    enable = lib.mkEnableOption {
      description = "Enable ${service}";
    };
    serviceName = lib.mkOption {
      type = lib.types.str;
      default = "${srv.linkdingName}"; # get name from default modules
    };
    linkding-env = lib.mkOption {
      description = "Credentials for linkding";
      default = null;
      type = lib.types.nullOr lib.types.path;
    };
  };
  config = lib.mkIf cfg.enable {

    assertions = [
      {
        assertion = cfg.linkding-env != null;
        message = "config.linkding.env cannot be null.";
      }
    ];
    # Create option for vvirtualisation service names
    # TODO: Kill process 9090 (docker version)
    virtualisation.oci-containers.containers."${cfg.serviceName}" = {
      image = "sissbruecker/linkding:latest";
      ports = [ "127.0.0.1:9091:9090" ];
      volumes = [ "linkding_data:/etc/linkding/data" ];
      environment = {
        LD_DISABLE_BACKGROUND_TASKS = "true";
        # LD_SUPERUSER_NAME = "thein3rovert";
        # LD_SUPERUSER_PASSWORD = "linkdinsam4496";
      };
      environmentFiles = [ cfg.linkding-env ];
    };
  };

}
