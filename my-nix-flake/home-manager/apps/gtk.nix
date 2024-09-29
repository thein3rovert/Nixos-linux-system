{ pkgs, ... }: {
 gtk = {
   enable = true;

   iconTheme = {
     name = "Reversal";
     package = pkgs.reversal-icon-theme;
   };

  #  cursorTheme = {
  #    name = "Bibata-Modern-Classic";
  #    size = 12;
  #  };

     font = {
       name = "JetBrainsMono Nerd Font";
       size = 11;
     };
 };

  # OLD THEME CHANGES - NOT SO NICE

# home.sessionVariables = { GTK_THEME = "Nordic"; };
# CHANGE CURSOR THEME IN CURSOR.NIX AND HOME SESSION IN HOME.NIX BEFORE REMOVING 
# CHANGE CURSOR THEME IN CURSOR.NIX AND HOME SESSION IN HOME.NIX BEFORE REMOVING 


  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "Nordic";
  #     package = pkgs.nordic;
  #   };
  #   cursorTheme = {
  #     name = "Catppuccin-Mocha-Dark-Cursors";
  #     package = pkgs.catppuccin-cursors.mochaDark;
  #   };
  #   iconTheme = {
  #     name = "Papirus-Dark";
  #     package = pkgs.papirus-icon-theme;
  #   };
  #   font = {
  #     name = "JetBrainsMono Nerd Font";
  #     size = 11;
  #   };
  #   gtk3.extraConfig = {
  #     gtk-xft-antialias = 1;
  #     gtk-xft-hinting = 1;
  #     gtk-xft-hintstyle = "hintslight";
  #     gtk-xft-rgba = "rgb";
  #     gtk-cursor-theme-name = "Catppuccin-Mocha-Green-Cursors";
  #   };
  #   gtk4.extraConfig = {
  #     gtk-xft-antialias = 1;
  #     gtk-xft-hinting = 1;
  #     gtk-xft-hintstyle = "hintslight";
  #     gtk-xft-rgba = "rgb";
  #     gtk-cursor-theme-name = "Catppuccin-Mocha-Green-Cursors";
  #   };
  # };

  # New Changes for dark themes

#    gtk = {
#     enable = true;
#     catppuccin = {
#       enable = true;
#       gnomeShellTheme = true;
#     };
#     iconTheme = {
#       name = "Tela-circle-dark";
#       package = pkgs.tela-circle-icon-theme;
#     };
#   #  cursorTheme = {
#  #     name = "Yaru";
# #      package = pkgs.yaru-theme;
# #    };
#     cursorTheme = {
#            name = "Catppuccin-Mocha-Dark-Cursors";
#            package = pkgs.catppuccin-cursors.mochaDark;
#          };
#     font = {
#       name = "Roboto";
#       size = 11;
#     };

#   };



#  qt = {
#    enable = true;
#    platformTheme.name = "qtct";
#    style.name = "kvantum";
#  };

  #  gtk = {
  #   enable = true;

  #   cursorTheme = {
  #       name = "Catppuccin-Macchiato-Blue";
  #       package = pkgs.catppuccin-cursors.macchiatoBlue;
  #   };

  #   theme = {
  #     name = "Catppuccin-Macchiato-Compact-Blue-dark";
  #     package = pkgs.catppuccin-gtk.override {
  #       size = "compact";
  #       accents = ["blue"];
  #       variant = "macchiato";
  #     };
  #   };

  #   iconTheme = {
  #     name = "Papirus-Dark";
  #     package = pkgs.papirus-folders;
  #   };

  #   gtk3.extraConfig = {
  #       Settings = ''
  #           gtk-application-prefer-dark-theme = 1;
  #       '';
  #   };

  #   gtk4.extraConfig = {
  #       Settings = ''
  #           gtk-application-prefer-dark-theme = 1;
  #           '';
  #   };

  # };
}
