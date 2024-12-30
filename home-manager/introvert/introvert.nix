{
  config,
  pkgs,
  inputs,
  ...
}: {
  users.users.introvert = {
    isNormalUser = true;
    description = "thein3rovert";
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "flatpak"
      "audio"
      "video"
      "plugdev"
      "input"
      "kvm"
      "qemu-libvirtd"
    ];
    
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };
  home-manager.users.introvert =
    import introvert/${config.networking.hostName}.nix;
}
