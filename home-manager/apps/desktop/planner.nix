{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.apps.desktop.planner;
in {
  options.apps.desktop.planner.enable = mkEnableOption "wayland extra tools and config";

  config = mkIf cfg.enable {
    programs.planner = {
      enable = true;
    };

    home.packages = with pkgs; [
      planner
    ];
  };
}
