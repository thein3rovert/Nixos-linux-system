{ config, lib, ... }:
with lib; let
  cfg = config.apps.cli.zsh;
in {
  options.apps.cli.zsh.enable = mkEnableOption "enable extended zsh configuration";
  
  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "docker-compose" "docker" ];
        theme = "dst";
      };
      initExtra = ''
        bindkey '^f' autosuggest-accept
        # OH-MY-POSH
        if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
          eval "$(oh-my-posh init zsh --config ~/.poshthemes/tokyonight_storm.omp.json )"
        fi
        
        export NIX_PATH="nixpkgs=channel:nixos-unstable"
        export NIX_LOG="info"
        export TERMINAL="kitty"

        # Check if the current TTY is /dev/tty1 and run Hyprland
        if [[ $(tty) == "/dev/tty1" ]]; then
          exec Hyprland &> /dev/null
        fi
      '';
      shellAliases = {
        ".." = "cd ..";
        "..." = "cd ../..";
        ls = "eza";
        grep = "rg";
        ps = "procs";
      };
    };
    
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
