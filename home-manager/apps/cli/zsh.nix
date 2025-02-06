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
        # Git related aliases
        ga = "git add";
        gc = "git commit -m";
        gs = "git status";
        gl = "git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all"; # check medium for better command line approach
        gp = "git push origin";
        gr = "git reset --soft HEAD~1";

      };
    };
    
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
