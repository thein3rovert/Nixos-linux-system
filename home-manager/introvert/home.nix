#{ inputs,username,config, pkgs, unstablePkgs, ... }:
{
  inputs,
  config,
  pkgs,
  unstablePkgs,
  ...
}:

let
  inherit (import ../../options.nix) gitUsername gitEmail;

in
{
  # IMPORTS FOR zsh config
  imports = [
    # Importing packages modules
    ../modules
    inputs.nix-colors.homeManagerModule
    # Imports from apps - configs for packages
    ../apps
  ];

  # Method 1: Configure nixpkgs

  colorScheme = inputs.nix-colors.colorSchemes.tokyo-night-terminal-storm;

  programs = {
    kitty = {
      enable = true;
      settings = {

        active_tab_foreground = "#${config.colorScheme.palette.base00}";
        active_tab_background = "#${config.colorScheme.palette.base0D}";

        foreground = "#${config.colorScheme.palette.base05}";
        background = "#${config.colorScheme.palette.base00}";
        url_color = "#${config.colorScheme.palette.base0E}";

        color0 = "#${config.colorScheme.palette.base00}"; # black
        color1 = "#${config.colorScheme.palette.base08}"; # red
        color2 = "#${config.colorScheme.palette.base0B}"; # green
        color3 = "#${config.colorScheme.palette.base0A}"; # yellow
        color4 = "#${config.colorScheme.palette.base0D}"; # blue
        color5 = "#${config.colorScheme.palette.base0E}"; # magenta
        color6 = "#${config.colorScheme.palette.base0C}"; # cyan
        color7 = "#${config.colorScheme.palette.base05}"; # white
        # terminal16
        color8 = "#${config.colorScheme.palette.base03}"; # bright black
        color9 = "#${config.colorScheme.palette.base08}"; # bright red
        color10 = "#${config.colorScheme.palette.base0B}"; # bright green
        color11 = "#${config.colorScheme.palette.base0A}"; # bright yellow
        color12 = "#${config.colorScheme.palette.base0D}"; # bright blue
        color13 = "#${config.colorScheme.palette.base0E}"; # bright magenta
        color14 = "#${config.colorScheme.palette.base0C}"; # bright cyan
        color15 = "#${config.colorScheme.palette.base07}"; # bright white

        # ...

        # add some nice default configs
        repaint_delay = "60";
        sync_to_monitor = "yes";
        background_opacity = "1.0";
        background_blur = "1";
        tab_bar_style = "powerline";
        tab_powerline_style = "round";
        font_family = "JetbrainsMono Nerd Font";
        bold_font = "auto";
        italic_font = " JetBrainsMono NFM Italic";
        bold_italic_font = "JetBrainsMono NFM Bold Italic";
        font_size = "10.0";
        cursor_shape = "beam";
        cursor_beam_thickness = "0.5";
        cursor_blink_interval = "0.5";
        strip_trailing_spaces = "always";
        update_check_interval = "0";

      };
    };
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  #  home.username = "${username}";
  home.username = "introvert";
  home.homeDirectory = "/home/introvert";
  #  home.homeDirectory =  lib.mkDefault "/home/${config.home.username}";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [

    # System Utilities
    htop
    tree
    brightnessctl # Brightness control
    fastfetch # System information fetcher

    # Text Editors and IDEs
    micro # Need the macro editor for testing purposes
    vscode
    #vscode-fhs

    # Fonts

    # Audio and Volume Control
    pavucontrol # Volume control
    playerctl # Media player control tool

    # Bluetooth
    blueman

    # Communication
    discord

    # Window Management and Locking
    hyprlock
    wlogout

    # Note-taking and Productivity
    obsidian

    # Appearance and Shell Customization
    oh-my-posh

    # Screenshot and Video Recording
    hyprshot # Screenshot tool
    obs-studio # Video recorder

    # GTK Libraries
    gtk3
    gtk4

    # Image Rendering Dependencies
    xorg.libX11
    cairo
    libpng
    librsvg

    # PDF and Document Viewing
    zathura

    # System Monitoring
    btop
    # Screen Recorder
    wf-recorder

    cowsay
    jetbrains.idea-ultimate
    docker-compose
    calcurse
    textsnatcher

  ];

  # ----------------------------------------------------------------------
  # Want to add ZSH, dont know much about it but i will do my research
  # -------------------------------- ZSH BENGINS HERE
  # UPDATE: ZSH config has been moved to app/zsh.nix file.

  # Also what to install FZF, dont know much about it but i will find out
  # ------------------------------FZF BEGINS HERE
  # -----------------------------FZF INTEGRATED WITH ZSH
  # UPDATE: FZF config has been moved to app/zsh.nix file.

  # SINCE THE CONFIG HAS BEEN MOVED WE WILL IMPORT THE zsh.nix folder in other to use the ZSH
  # IMPORTS CAN BE FOUND AT THE TOP OF THE FILE
  #------------------------------------------------------------------------

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/introvert/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    #GTK_THEME = "Nordic";
    # EDITOR = "emacs";
    #For invisible cursor
    WLR_NO_HARDWARE_CURSORS = "1";
    #Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1"; # cant use this now
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  #nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowUnfreePredicate = _: true;

  ########
  # WAYBAR
  ########
  programs.waybar = {
    enable = true;
  };

}
