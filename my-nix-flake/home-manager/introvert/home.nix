
#{ inputs,username,config, pkgs, unstablePkgs, ... }:
{ inputs,config, pkgs, unstablePkgs, ... }:

let 
  inherit (import ../../options.nix)
    gitUsername gitEmail;
in {


  # IMPORTS FOR zsh config
  imports = [
      # Importing packages modules
    ../modules
    # Imports from apps - configs for packages
    ../apps/zsh.nix
    ../apps/micro.nix
    ../apps/git.nix
    ../apps/gtk.nix
    ../apps/portals.nix
    ../apps/cursor.nix
    ../apps/htop.nix
    ../apps/java.nix
  #./software/default.nix
  ../apps/vscode.nix
  # ./apps/xdg.nix  - dont need for now user-dirs.dirs is okay
 # ./apps/spotify.nix
  # ./apps/pywal.nix
  ../common
  ];

  # catppuccin = {
  #      enable = true;
  #       accent = "mauve";
  #       flavor = "mocha"; #mocha
      
  # };

  # nixpkgs = {
  # 		# You can add overlays here
  # 		overlays = [
  # 			# If you want to use overlays exported from other flakes:
  # 			# neovim-nightly-overlay.overlays.default
  
  # 			# Or define it inline, for example:
  # 			# (final: prev: {
  # 			#	 hi = final.hello.overrideAttrs (oldAttrs: {
  # 			#		 patches = [ ./change-hello-to-hi.patch ];
  # 			#	 });jsvd
  # 			# })
  # 		];
  # 		# Configure your nixpkgs instance
  # 		config = {
  # 			# Disable if you don't want unfree packages
  # 			allowUnfree = true;
  # 			# Workaround for https://github.com/nix-community/home-manager/issues/2942
  # 			allowUnfreePredicate = _: true;
  # 		};
  # 	};

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
  brightnessctl  # Brightness control
  fastfetch  # System information fetcher

  # Text Editors and IDEs
  micro  # Need the macro editor for testing purposes
  vscode

  # Fonts

  # Audio and Volume Control
  pavucontrol  # Volume control
  playerctl  # Media player control tool

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
  hyprshot  # Screenshot tool
  obs-studio  # Video recorder

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
