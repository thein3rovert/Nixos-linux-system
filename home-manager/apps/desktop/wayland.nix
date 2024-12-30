{ config, pkgs, ... }:
let
  waylandTools = true;  # Set to true to enable
in
{
  home.packages = with pkgs;
    (if waylandTools then [       
      grim
      hyprlock
      qt6.qtwayland
      slurp
      waypipe
      wf-recorder
      wl-mirror
      wl-clipboard
      wlogout
      wtype
      ydotool 
      xclip
    ] else []);
}
