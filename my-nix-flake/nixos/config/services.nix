{ pkgs, config, lib, ... }:

{
#  xdg.portal = {
#    enable = true;
#    extraPortals = [ 
#      #pkgs.xdg-desktop-portal-gtk
#      pkgs.xdg-desktop-portal
#      pkgs.xdg-desktop-portal-wlr 
#    ];
#    configPackages = [ 
#      pkgs.xdg-desktop-portal-wlr 
#      #pkgs.xdg-desktop-portal-gtk
#      pkgs.xdg-desktop-portal-hyprland
#      pkgs.xdg-desktop-portal
#    ];
#  };

 
  # List services that you want to enable:
  services.openssh.enable = true;
#  services.fstrim.enable = true;
#  services.vnstat.enable = true;
#  services.gvfs.enable = true;
#  services.tumbler.enable = true;
#  services.upower.enable = true;
#  services.thermald.enable = false;
#  services.hypridle.enable = true;
  services.power-profiles-daemon.enable = true;  # Not in main config
  services.gnome.gnome-keyring.enable = true;  # Not in main config
  services.gnome.gnome-remote-desktop.enable = true; # Not in main config
  services.blueman.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    audio.enable = true;
    pulse.enable = true;
#    socketActivation = true;
#    jack.enable = true;
#   wireplumber.enable = true;
  };
#  services.resolved = {
#   enable = true;
#    dnssec = "true";
#    dnsovertls = "true";
#    fallbackDns = [ "165.22.52.204" ];
#    extraConfig = ''
#      Domains=~.
#      DNS= 1.1.1.1:853 1.0.0.1:853 2606:4700:4700::1111 2606:4700:4700::1001###

#      [Proxy]
#      Proxy=socks5://127.0.0.1:1080
#    '';
#  };

  # Hardware
  hardware.enableAllFirmware = true;   # Not in main config
  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true; # enables support for Bluetooth   # Not in main config
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };


  #Security
  security.rtkit.enable = true;
#  security.pam.services.hyprlock = {};
#  security.pam.services.swaylock = {
#    text = ''
#      auth include login
#   '';
#  };
 }
