{ pkgs, config, ... }:

{
  # Bootloader
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.kernel.sysctl = { "vm.max_map_count" = 2147483642; };
  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "25%";
  boot.kernelModules = [ "i2c-dev" ];

#  This is for OBS Virtual Cam Support - v4l2loopback setup
#  boot.kernelModules = [ "v4l2loopback" ];
# For More advance config file https://www.youtube.com/watch?v=nJ6glhP7JI0 


}
