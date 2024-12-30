{ pkgs, config, lib, ... }:

{
  security.rtkit.enable = true;
#  security.pam.services.hyprlock = {};
#  security.pam.services.swaylock = {
#    text = ''
#      auth include login
#   '';
#  };

}
