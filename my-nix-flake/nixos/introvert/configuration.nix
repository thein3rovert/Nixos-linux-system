
 # Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs,username, hostname, ... }:

let 
  inherit (import ../../options.nix) 
    theLocale theTimezone gitUsername
    theShell theLCVariables theKBDLayout flakeDir
    httpProxy socksProxy;gf
in 

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../config # Contains hardware files
    ];


     services.udev.packages = [
    (pkgs.runCommand "custom-udev-rules" {
      buildInputs = [ pkgs.coreutils ];
    } ''
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
  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtw88
  ];
  # Disable power managemnet
   boot.kernelParams = [ "rtw_8821ce.disable_msi=1" "rtw_8821ce.disable_aspm=1" ];



#   __  __  ____  ___   ___ 
#  (  \/  )(_  _)/ __) / __)
#   )    (  _)(_ \__ \( (__ 
#  (_/\/\_)(____)(___/ \___)

#qt.enable = true;
#qt.style.name = "gtk2";

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
  networking.hostName = "${hostname}"; # Define your hostname
  networking.networkmanager.enable = true;
  
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
 security.sudo.extraRules = [{
   users = ["introvert"];
   commands = [{ command = "ALL";
     options = ["NOPASSWD"];
    }];
  }];

#   __  __  ___  ____  ____  ___ 
#  (  )(  )/ __)( ___)(  _ \/ __)
#   )(__)( \__ \ )__)  )   /\__ \
#  (______)(___/(____)(_)\_)(___/


    users = {
    users."${username}" = { 
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [ "networkmanager" "wheel" "i2c" ];
      shell =pkgs.${theShell};
      ignoreShellProgramCheck = true;
      packages = with pkgs; [
    #  thunderbird
      ];
    };
  };

#   ____  _  _  _  _ 
#  ( ___)( \( )( \/ )
#   )__)  )  (  \  / 
#  (____)(_)\_)  \/  

  environment.variables = {
      FLAKE = "${flakeDir}";
       QT_QPA_PLATFORMTHEME = "qt5ct";   # For Qt5 applications
     #  QT_QPA_PLATFORMTHEME = "qt6ct";   # For Qt6 applications
    
#      QT_QPA_PLATFORMTHEME = "kvantum";
 #     QT_STYLE_OVERRIDE = "kvantum";
     # POLKIT_BIN = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
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
  #SHELL CONFIGURATION
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  
  programs.hyprland = {
    enable = true;
     portalPackage = pkgs.xdg-desktop-portal-wlr
      // {
        override = args: pkgs.xdg-desktop-portal-wlr.override (builtins.removeAttrs args ["hyprland"]);
      };
   xwayland.enable = true; # I dont jabe xwayland yet so i am not using it
  };
  
  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;


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
    wget
    git
    neovim
    
  # Waybar with experimental features enabled
  (waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true"];
  }))


  # Notification tools
  dunst        # For notifications
  libnotify    # Helps with Dunst notifications
  blueberry    # Helps with Bluetooth configuration
  
  # Miscellaneous utilities
  swww                      # For wallpaper management
  kitty                     # Terminal emulator
  rofi-wayland              # Application launcher for Wayland
  networkmanagerapplet      # Network Manager applet
#  xcb-util-cursor           # XCB cursor utilities
  xorg.libxcb               # Xorg XCB libraries
  ddcutil                   # Brighness contro, works for external monitor
  pulseaudio 
#-------------------------
  xdg-user-dirs
  xdg-utils
  # Desktop Theming
  qt5ct
  qt6ct
  qt6.qtwayland
  qt6Packages.qtstyleplugin-kvantum #kvantum
  libsForQt5.qtstyleplugin-kvantum
  gtk-engine-murrine

  anki-bin
  spacedrive

  sshfs
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
      (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" ]; })
    ];
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
#  nix.settings.experimental-features = [ "nix-command" "flakes" ];

 #  blueman.enable = true;
 #  dbus.enable = true;
    }


