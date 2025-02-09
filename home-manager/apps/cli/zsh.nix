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
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
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
        # Dirs
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
        "......" = "cd ../../../../..";

        # Eza
        l = "eza -l --icons --git -a";
        lt = "eza --tree --level=2 --long --icons --git";
        ltree = "eza --tree --level=2 --icons --git";
        ls = "eza";

        # Processes and Memory
        grep = "rg";
        ps = "procs";

        # Git
        ga = "git add";
        gc = "git commit -m";
        gs = "git status";
        gl = "git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all"; # check medium for better command line approach
        gp = "git push origin";
        gr = "git reset --soft HEAD~1";
        gdiff = "git diff";
        gco = "git checkout";
        gb = "git branch";
        glog = "git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit";
        gpu = "git pull origin";

        cat = "bat";

      };
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
