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
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };
  users.extraGroups.docker.members = ["thein3rovert"];
  
  home-manager.users.introvert =
    import introvert/${config.networking.hostName}.nix;
}
