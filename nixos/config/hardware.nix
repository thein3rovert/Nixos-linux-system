{ pkgs, config, lib, ... }:

{
   hardware.opengl = {
    enable = true;
    };

  hardware.enableAllFirmware = true;   # Not in main config
  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true; # enables support for Bluetooth   # Not in main config
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

  }
