{ pkgs, ... }:

# ENABLE XDG PORTAL SERVICES AND ADDED EXTRAL PORTAL SPECIFIC TO WAYLAND. 
# This helps yo allow all types of prtals.
{
  xdg.portal = {
   enable = true;
   config.common.default = "*";
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-hyprland
    ];
  };
}
