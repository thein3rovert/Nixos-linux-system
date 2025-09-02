{
  config,
  lib,
  pkgs,
  ...
}:
let

  cfg = config.nixosSetup.programs.uxplay;
in
{
  options.nixosSetup.programs.uxplay = {
    enable = lib.mkEnableOption "Uxplay Airplay";
    # WHy is this of type submodules and not jst an option
    firewall = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "open required firewall ports";
          allowedTCPPorts = lib.mkOption {
            type = lib.types.listof lib.types.port;
            default = [
              7000
              7001
              20
              21
            ];
          };
          allowedUDPPorts = lib.mkOption {
            type = lib.types.listof lib.types.port;
            default = [
              5353
              6000
              6001
              7011
            ];
          };
          allowedTCPPortRanges = lib.mkOption {
            type = lib.types.listof (
              lib.types.submodule {
                options = {
                  from = lib.mkOption {
                    type = lib.types.port;
                  };
                  to = lib.mkOption { type = lib.types.port; };
                };
              }
            );
          };
        };
      };
      default = {
        enable = true;
      };
    };

    avahi = lib.mkOption {
      type = lib.types.submodule {
        options = {
          enable = lib.mkEnableOption "Enable avahi for discovery";
          publish = lib.mkOption {
            type = lib.types.attrOf lib.types.bool;
            default = {
              enable = true;
              addresses = true;
              workstation = true;
              userServices = true;
              domain = true;
            };
          };
        };
      };
      default = {
        enable = true;
      };
    };

    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ pkgs.uxplay ];
      descriptions = "Extra [packages to install uxPlay.";
    };

    config = lib.mkIf cfg.enable {
      networking.firewall = lib.mkIf cfg.enable.firewall.enable {
        allowedTCPPorts = cfg.firewall.allowedTCPPorts;
        allowedUDPPort = cfg.firewall.allowedUDPPort;
        allowedTCPPortRanges = cfg.firewall.allowedTCPPortRanges;
      };

      services.avahi = lib.mkIf cfg.avahi.enable {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
        publish = cfg.avahi.publish;
      };
      environment.systemPackages = cfg.extraPackages;
    };

  };
}
