# TODO: Make dynamic (option and submodles)
{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.nixosSetup.desktop.fonts.enable = lib.mkEnableOption "All System Fonts";

  config = lib.mkIf config.nixosSetup.desktop.fonts.enable {

    # INFO: Not all font needs to be usesd so i need to add option
    # to enable and disable fonts.

    fonts = {
      fontDir.enable = true;
      enableGhostscriptFonts = true;
      packages = with pkgs; [
        cantarell-fonts
        hack-font
        inter
        jetbrains-mono
        liberation_ttf
        monaspace
        noto-fonts
        ubuntu_font_family
        nerd-fonts.fira-code
        nerd-fonts.droid-sans-mono
        nerd-fonts.jetbrains-mono
        dankmono-nerdfonts

        fira-code
        fira-code-symbols
        nerd-fonts.fira-code
        font-manager
        font-awesome_5
        noto-fonts
      ];
    };
  };
}
