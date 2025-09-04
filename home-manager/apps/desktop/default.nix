{ pkgs, ... }:
{
  imports = [
    # ./wayland.nix
    ./fonts.nix
    ./cursor.nix
    ./gtk.nix
    ./wayland.nix
    ./micro.nix
    # ./vscode.nix
    ./portals.nix
  ];

  home.packages = with pkgs; [
    # gimp-with-plugins
    # whatsapp-for-linux
    # sticky
    # spotify
    # flameshot
  ];
}
