# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs,username, hostname, ... }:

let 
  inherit (import ../options.nix) 
    theLocale theTimezone gitUsername
    theShell theLCVariables theKBDLayout flakeDir
    httpProxy socksProxy;
in 

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./config
    ];

#   ____  _____  _____  ____ 
#  (  _ \(  _  )(  _  )(_  _)
#   ) _ < )(_)(  )(_)(   )(  
#  (____/(_____)(_____) (__) 

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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

 #  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.hostName = "${hostname}"; # Define your hostname
  networking.networkmanager.enable = true;
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

#   ___  ____  ____   _  ____  ___  ____  ___ 
#  / __)( ___)(  _ \( \/ )(_  _)/ __)( ___)/ __)
#  \__ \ )__)  )   / \  /  _)(_( (__  )__) \__ \
#  (___/(____)(_)\_)  \/  (____)\___)(____)(___/
      # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.blueman.enable =true;
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
  
      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

  # Configure keymap in X11
  services.xserver = {
    layout = "gb";
    xkbVariant = "";
  };
    # List services that you want to enable:
    services.openssh.settings.PasswordAuthentication = false;
    services.openssh.settings.KbdInteractiveAuthentication = false;

    #Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

#   _   _    __    ____  ____  _    _    __    ____  ____ 
#  ( )_( )  /__\  (  _ \(  _ \( \/\/ )  /__\  (  _ \( ___)
#   ) _ (  /(__)\  )   / )(_) ))    (  /(__)\  )   / )__) 
#  (_) (_)(__)(__)(_)\_)(____/(__/\__)(__)(__)(_)\_)(____)

# BLUETOOTH CONFI HAS BEEN MOVED TO THE SERVICES.NIX
#   ___  ____  ___  __  __  ____  ____  ____  _  _ 
#  / __)( ___)/ __)(  )(  )(  _ \(_  _)(_  _)( \/ )
#  \__ \ )__)( (__  )(__)(  )   / _)(_   )(   \  / 
#  (___/(____)\___)(______)(_)\_)(____) (__)  (__) 

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
      extraGroups = [ "networkmanager" "wheel" ];
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

  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  programs.hyprland = {
    enable = true;
   #xwayland.enable - true; # I dont jabe xwayland yet so i am not using it
  };
  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    
    (waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true"]; }))
      
    dunst #for notification
    libnotify #helps with dunst notification
    swww #for wallpaper
    kitty #new terminal
    rofi-wayland
    networkmanagerapplet
    xcb-util-cursor
    xorg.libxcb
   ];

#   _  _  ____  _  _    ___  ____  ____  ____  ____  _  _  ___  ___ 
#  ( \( )(_  _)( \/ )  / __)( ___)(_  _)(_  _)(_  _)( \( )/ __)/ __)
#   )  (  _)(_  )  (   \__ \ )__)   )(    )(   _)(_  )  (( (_-.\__ \
#  (_)\_)(____)(_/\_)  (___/(____) (__)  (__) (____)(_)\_)\___/(___/

   # Optimization settings and garbage collection automation
   nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
     # substituters = ["https://hyprland.cachix.org"];
     # trusted-public-keys = [
     #   "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
     # ];
    };
    gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
        };
    };



  
    
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;7
  #   enableSSHSupport = true;
  # };
  #SCREEN SHARING, LINK OPENING, FILE OPENING AND MORE
 # xdg.portal = {
  #  enable = true;
  #  extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
 # };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
#  nix.settings.experimental-features = [ "nix-command" "flakes" ];

    }


