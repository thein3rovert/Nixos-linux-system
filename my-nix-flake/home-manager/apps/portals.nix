{ pkgs, ... }: {
  # Configuration for XDG portals
  xdg.portal = {
    # Enable the XDG portal system
    enable = true;

    # Configure the behavior of the XDG portal system
    config = {
      common = {
        # Set the default portal implementation to "hyprland"
        # This means the XDG portal will prioritize using Hyprland
        # for providing desktop services to applications.
        default = [
          "hyprland"
        ];
      };
    };

    # Specify additional portal backends that should be available.
    extraPortals = with pkgs; [
      # Hyprland-specific portal integration.
      # This ensures that Hyprland features work correctly with the XDG portal system.
      xdg-desktop-portal-hyprland

      # GTK-specific portal integration.
      # This is necessary for applications that use the GTK toolkit to interact
      # with the desktop environment, e.g., for file dialogs or notifications.
      xdg-desktop-portal-gtk

      # KDE-specific portal integration.
      # This provides similar integration for applications designed for KDE,
      # ensuring they can use the XDG portal system to interact with the desktop.
      xdg-desktop-portal-kde
    ];
  };
}
