{ pkgs }:
let
  stdenvNoCC = pkgs.stdenvNoCC;
  lib = pkgs.lib;
in
stdenvNoCC.mkDerivation {
  pname = "dankmono-nerdfonts";
  version = "2.015";
  src = ./fonts/dank-mono;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype/
    cp -r $src/*.{ttf,otf} $out/share/fonts/truetype/
  '';

  meta = with lib; {
    description = "dankmono-regular";
    homepage = "https://www.dankmono.com/";
    platforms = platforms.all;
  };
}
