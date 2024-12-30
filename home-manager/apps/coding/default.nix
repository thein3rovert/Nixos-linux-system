{pkgs, ...}: {
  imports = [
#  ./emacs.nix
 #  ./golang.nix
#  ./nix.nix
 #  ./nodejs.nix
#    ./rust.nix
     ./tools.nix];

  home.packages = with pkgs; [
#    cachix
#    cmake
#    gcc
#    ispell
#    guile_3_0
#    tinyscheme
    python3
  ];
}
