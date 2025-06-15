{ config, lib, ... }:
with lib;
let
  cfg = config.apps.cli.zsh;
in
{
  options.apps.cli.zsh.enable = mkEnableOption "enable extended zsh configuration";

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      #  enableSyntaxHighlighting = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "docker-compose"
          "docker"
        ];
        theme = "dst";
      };
      initExtra = ''
              bindkey '^f' autosuggest-accept
              # OH-MY-POSH
              if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
                eval "$(oh-my-posh init zsh --config ~/.poshthemes/catppuccin_macchiato.omp.json )"
              fi

              export NIX_PATH="nixpkgs=channel:nixos-unstable"
              export NIX_LOG="info"
              export TERMINAL="kitty"

              export PATH="$HOME/bin:$PATH"

              # Check if the current TTY is /dev/tty1 and run Hyprland
              if [[ $(tty) == "/dev/tty1" ]]; then
                exec Hyprland &> /dev/null
              fi

               # Git Commit Message Function
        cmsg() {
          if [ -z "$4" ]; then
            git commit -m "$1($2): $3"
          else
            git commit -m "$1($2): $3" -m "$4"
          fi
        }
      '';
      shellAliases = {
        # Dirs
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
        "......" = "cd ../../../../..";

        # Eza
        ltree = "eza -l --icons --git -a";
        l = "eza --tree --level=2 --icons --git"; # Previous Command - ltree
        lt = "eza --tree --level=2 --long --icons --git";
        ls = "eza --icons";

        # Processes and Memory
        grep = "rg";
        ps = "procs";

        # Git
        ga = "git add";
        gc = "git commit -m";
        #gc = "cmsg"; # The contains "git commit -m"
        gs = "git status";

      };
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
