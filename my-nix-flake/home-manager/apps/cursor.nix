{ pkgs, ... }: {
 home.pointerCursor = {
   name = "Bibata-Modern-Classic";
   size = 16;
  package = pkgs.bibata-cursors;
 };
  # home.pointerCursor = {
  #   name = "Catppuccin-Mocha-Dark-Cursors";
  #   package = pkgs.catppuccin-cursors.mochaDark;
  #   size = 16;
  # };
}
