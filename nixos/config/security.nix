{ pkgs, config, lib, ... }:

{
  security.rtkit.enable = true;
#  security.pam.services.hyprlock = {};
#  security.pam.services.swaylock = {
#    text = ''
#      auth include login
#   '';
#  };

  # Ensure the group exists
  users.groups.wireshark = { };

  security.wrappers.dumpcap = {
    owner = "root";
    group = "wireshark";
    capabilities = "cap_net_raw,cap_net_admin+eip";
    source = "${pkgs.wireshark}/bin/dumpcap";
  };

  users.users.introvert.extraGroups = [ "wireshark" ];



}
