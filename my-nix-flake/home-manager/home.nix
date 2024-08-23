{ inputs,username,config, pkgs, unstablePkgs, ... }:

let 
  inherit (import ../options.nix)
    gitUsername gitEmail;
in {


  # IMPORTS FOR zsh config
  imports = [
    ./apps/zsh.nix
  #IMPORT FROM MICRO config
    ./apps/micro.nix
    ./apps/git.nix
    # Importing modules
    ./modules
    ./apps/gtk.nix
    ./apps/portals.nix
    ./apps/cursor.nix
    ./apps/htop.nix
    #./software/default.nix
    ./apps/vscode.nix
  ];

  catppuccin = {
        accent = "mauve";
        flavor = "macchiato";
      };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    htop
   #.............. Need the macro editor for testing pourpose
    micro
    vscode
    tree
    nerdfonts
    pavucontrol # volume control
    brightnessctl # Brightness control
    blueman
    discord
    hyprlock
    wlogout
    obsidian 
    oh-my-posh
    hyprshot #Screenshot
    obs-studio # Video Recorder
    gtk3
    gtk4
    fastfetch
    #Image redenring dependencies
    xorg.libX11
    cairo
    libpng
    librsvg

    zathura
    btop

    playerctl


    
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
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
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  ########
 # WAYBAR
  ########
  programs.waybar = {
    enable = true;
  };
}
