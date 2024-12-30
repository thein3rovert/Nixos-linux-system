{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.apps.cli.atac;
in {
  options.apps.cli.atac.enable = mkEnableOption "enable trello";

  config = mkIf cfg.enable {
        programs.atac = {
      enable = true;
    };
    home.packages = with pkgs; [atac];
  };
}