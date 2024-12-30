{ pkgs, ... }: {
 home.pointerCursor = {
   name = "Bibata-Modern-Ice";
   size = 8;
  package = pkgs.bibata-cursors;
 };
  # home.pointerCursor = {
  #   name = "Catppuccin-Mocha-Dark-Cursors";
  #   package = pkgs.catppuccin-cursors.mochaDark;
  #   size = 16;
  # };
}
