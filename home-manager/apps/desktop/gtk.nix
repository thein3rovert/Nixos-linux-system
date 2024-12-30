{ pkgs, ... }: {
  gtk = {
    enable = true;
     theme = {
       name = "Tokyonight-Dark";
       package = pkgs.tokyonight-gtk-theme;
     };
   iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
   };
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-cursor-theme-name = "breeze_cursors";
      gtk-cursor-theme-size = 24;
      gtk-font-name = "JetBrainsMono Nerd Font 11";
      gtk-theme-name = "Tokyonight-Dark";
      gtk-icon-theme-name = "Papirus-Dark";
      gtk-application-prefer-dark-theme = true;
      gtk-button-images = false;
      gtk-decoration-layout = "icon :minimize,maximize,close";
      gtk-enable-animations = true;
      gtk-enable-event-sounds = true;
      gtk-enable-input-feedback-sounds = false;
      gtk-menu-images = false;
      gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
      gtk-toolbar-style = 3;
      gtk-modules = "colorreload-gtk-module:window-decorations-gtk";
    };
    gtk4.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
      gtk-cursor-theme-name = "breeze_cursors";
      gtk-cursor-theme-size = 24;
      gtk-font-name = "JetBrainsMono Nerd Font 11";
      gtk-theme-name = "Tokyonight-Dark";
      gtk-icon-theme-name = "Papirus-Dark";
      gtk-application-prefer-dark-theme = true;
      gtk-button-images = false;
      gtk-decoration-layout = "icon :minimize,maximize,close";
      gtk-enable-animations = true;
      gtk-enable-event-sounds = true;
      gtk-enable-input-feedback-sounds = false;
      gtk-menu-images = false;
      gtk-toolbar-icon-size = "GTK_ICON_SIZE_LARGE_TOOLBAR";
      gtk-toolbar-style = 3;
      gtk-modules = "colorreload-gtk-module:window-decorations-gtk";
    };
  };
}
