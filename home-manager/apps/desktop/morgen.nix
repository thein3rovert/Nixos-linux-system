{ config, pkgs, ... }:
let
  calender = true;  # Set to true to enable
in
{
  home.packages = with pkgs;
    (if calender then [ morgen ] else []);
}