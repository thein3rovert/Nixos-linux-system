# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

#{ config, pkgs,username, hostname, ... }:
{
  config,
  pkgs,
  inputs,
  ...
}:

let
  dankmono-nerdfonts = pkgs.callPackage ../config/dankMono.nix { inherit pkgs; };
  inherit (import ../../options.nix)
    theLocale
    theTimezone
    theLCVariables
    theKBDLayout
    flakeDir
    ;
in
{
  imports = [
    ./hardware-configuration.nix
    ../config
  ];

  # -------------------
  # CUSTOM MODULES
  # --------------------
  nixosSetup = {
    programs = {
      podman.enable = true;
      obs-studio.enable = true;
      uxplay = {
        enable = true;

        firewall = {
          enable = false;
          allowedTCPPorts = [
            7000
            7001
          ]; # override defaults if you want
          allowedUDPPorts = [
            5353
            6000
            6001
          ];
        };

        avahi = {
          enable = true;
          publish = {
            enable = true;
            workstation = true; # e.g. override just one
          };
        };

        extraPackages = with pkgs; [
          uxplay
          vlc
        ];
      };
    };
    services = {
      linkding.enable = true;
    };
  };

  services.udev.packages = [
    (pkgs.runCommand "custom-udev-rules" { buildInputs = [ pkgs.coreutils ]; } ''
      mkdir -p $out/lib/udev/rules.d
      cp ${pkgs.ddcutil}/share/ddcutil/data/60-ddcutil-i2c.rules $out/lib/udev/rules.d/
    '')
  ];

  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  #   ____  _____  _____  ____
  #  (  _ \(  _  )(  _  )(_  _)
  #   ) _ < )(_)(  )(_)(   )(
  #  (____/(_____)(_____) (__)
  #

  ## For updating my driver
  boot.extraModulePackages = with config.boot.kernelPackages; [ rtw88 ];
  # Disable power managemnet
  boot.kernelParams = [
    "rtw_8821ce.disable_msi=1"
    "rtw_8821ce.disable_aspm=1"
  ];

  #   __  __  ____  ___   ___
  #  (  \/  )(_  _)/ __) / __)
  #   )    (  _)(_ \__ \( (__
  #  (_/\/\_)(____)(___/ \___)

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "${theLocale}";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${theLCVariables}";
    LC_IDENTIFICATION = "${theLCVariables}";
    LC_MEASUREMENT = "${theLCVariables}";
    LC_MONETARY = "${theLCVariables}";
    LC_NAME = "${theLCVariables}";
    LC_NUMERIC = "${theLCVariables}";
    LC_PAPER = "${theLCVariables}";
    LC_TELEPHONE = "${theLCVariables}";
    LC_TIME = "${theLCVariables}";
  };
  console.keyMap = "${theKBDLayout}"; # Currently us but initially uk

  # Set your time zone.
  time.timeZone = "${theTimezone}";

  #   _  _  ____  ____  _    _  _____  ____  _  _
  #  ( \( )( ___)(_  _)( \/\/ )(  _  )(  _ \( )/ )
  #   )  (  )__)   )(   )    (  )(_)(  )   / )  (
  #  (_)\_)(____) (__) (__/\__)(_____)(_)\_)(_)\_)

  # Enable networking
  #  networking.hostName = "${hostname}"; # Define your hostname
  networking.hostName = "nixos"; # Define your hostname
  networking.networkmanager.enable = true;

  # virtualisation.docker.enable = true;
  # virtualisation.docker.rootless = {
  #   enable = true;
  #   setSocketVariable = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  #  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  #  networking.proxy.default = "${socksProxy}";
  #  networking.proxy.allProxy = "${socksProxy}";
  #  networking.proxy.rsyncProxy = "${socksProxy}";
  #  networking.proxy.httpProxy = "${httpProxy}";
  #  networking.proxy.httpsProxy = "${httpProxy}";
  #  networking.proxy.ftpProxy = "${httpProxy}";

  # Configuring NETWORK SETUP
  #networking.firewall.enable = true;
  #networking.forwarding = true;
  # boot.kernel.sysctl."net.inet.ip_forward" = 1;

  security.rtkit.enable = true;
  security.sudo.extraRules = [
    {
      users = [ "introvert" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  #   __  __  ___  ____  ____  ___
  #  (  )(  )/ __)( ___)(  _ \/ __)
  #   )(__)( \__ \ )__)  )   /\__ \
  #  (______)(___/(____)(_)\_)(___/

  ## This user config has been moved to the "common/user" folder
  #INFO: UPPDATE: This config has been moved back from the common folder

  users.groups.introvert = { };
  users.users.introvert = {
    isNormalUser = true;
    description = "thein3rovert";
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "flatpak"
      "audio"
      "video"
      "plugdev"
      "input"
      "kvm"
      "qemu-libvirtd"
    ];
    packages = [ inputs.home-manager.packages.${pkgs.system}.default ];
  };

  #   ____  _  _  _  _
  #  ( ___)( \( )( \/ )
  #   )__)  )  (  \  /
  #  (____)(_)\_)  \/

  environment.variables = {
    FLAKE = "${flakeDir}";
    QT_QPA_PLATFORMTHEME = "qt5ct"; # For Qt5 applications
  };
  environment.sessionVariables = {
    #For invisible cursor
    WLR_NO_HARDWARE_CURSORS = "1";
    #Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1"; # cant use this now
  };

  #   ____  ____  _____  ___  ____    __    __  __  ___
  #  (  _ \(  _ \(  _  )/ __)(  _ \  /__\  (  \/  )/ __)
  #   )___/ )   / )(_)(( (_-. )   / /(__)\  )    ( \__ \
  #  (__)  (_)\_)(_____)\___/(_)\_)(__)(__)(_/\/\_)(___/

  #  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-wlr // {
      override = args: pkgs.xdg-desktop-portal-wlr.override (builtins.removeAttrs args [ "hyprland" ]);
    };
  };

  # programs.firefox.enable = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
    openssl
    libkrb5
    util-linux
    glibc
  ];

  # nixpkgs.config.allowUnfree = true;

  #     _____           _                   _____           _
  #    / ____|         | |                 |  __ \         | |
  #   | (___  _   _ ___| |_ ___ _ __ ___   | |__) |_ _  ___| | ____ _  __ _  ___  ___
  #    \___ \| | | / __| __/ _ \ '_ ` _ \  |  ___/ _` |/ __| |/ / _` |/ _` |/ _ \/ __|
  #    ____) | |_| \__ \ ||  __/ | | | | | | |  | (_| | (__|   < (_| | (_| |  __/\__ \
  #   |_____/ \__, |___/\__\___|_| |_| |_| |_|   \__,_|\___|_|\_\__,_|\__, |\___||___/
  #            __/ |                                                   __/ |
  #           |___/                                                   |___/
  environment.systemPackages = with pkgs; [
    vim
    git
    neovim
    # Waybar with experimental features enabled
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    }))

    # Notification tools
    dunst # For notifications
    libnotify # Helps with Dunst notifications
    blueberry # Helps with Bluetooth configuration

    # Miscellaneous utilities
    swww # For wallpaper management
    kitty # Terminal emulator
    rofi-wayland # Application launcher for Wayland
    networkmanagerapplet # Network Manager applet
    #  xcb-util-cursor           # XCB cursor utilities
    xorg.libxcb # Xorg XCB libraries
    pulseaudio
    #-------------------------
    xdg-user-dirs
    xdg-utils
    # Desktop Theming
    libsForQt5.qt5ct # This is the new replacement
    qt6.qtwayland
    qt6Packages.qtstyleplugin-kvantum # kvantum
    libsForQt5.qtstyleplugin-kvantum
    gtk-engine-murrine

    nix-ld
    nixd

    sshfs
    tokyonight-gtk-theme

    inputs.zen-browser.packages."${system}".default

    # lazydocker
    #
    nh
    gparted

    # === Moved Home-Manager Packages ===
    coreutils
    fd
    htop
    httpie
    jq
    procs
    ripgrep
    tldr
    zip

    ##  Important files for neovim config
    lua-language-server
    lua51Packages.lua
    gccgo14
    luajitPackages.luarocks
    tree-sitter
    vimPlugins.luasnip
    python312Packages.pip
    prettierd
    unzip
    luajitPackages.jsregexp
    just
    cargo
    nil # Used for my lua-language-server

    #   === Packages for home.nix ===
    # System Utilities
    htop
    tree
    brightnessctl # Brightness control
    fastfetch # System information fetcher

    # Text Editors and IDEs
    vscode

    # Fonts

    # Audio and Volume Control
    pavucontrol # Volume control
    playerctl # Media player control tool

    # Bluetooth
    blueman

    # Communication
    # discord

    # Window Management and Locking
    hyprlock
    wlogout

    # Note-taking and Productivity
    obsidian

    # Appearance and Shell Customization
    oh-my-posh

    # Screenshot and Video Recording
    hyprshot # Screenshot tool
    # obs-studio # Video recorder

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

    textsnatcher

  ];

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

      # === INFO: Moved homr-manager fonts ===
      fira-code
      fira-code-symbols
      nerd-fonts.fira-code
      font-manager
      font-awesome_5
      noto-fonts
    ];
  };

  ########
  # WAYBAR
  ########
  programs.waybar = {
    enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;7
  #   enableSSHSupport = true;
  # };
  swapDevices = [ { device = "/swapfile"; } ];
  system.stateVersion = "24.05"; # Did you read the comment?

  #  blueman.enable = true;
  #  dbus.enable = true;
}
