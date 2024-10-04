{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.apps.cli.zsh;
in {
  options.apps.cli.zsh.enable = mkEnableOption "enable extended zsh configuration";

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;

       initExtra = ''
      export NIX_PATH="nixpkgs=channel:nixos-unstable"
      export NIX_LOG="info"
      export TERMINAL="kitty"

       # Debugging output
  echo "NIX_PATH set to: $NIX_PATH"
  echo "NIX_LOG set to: $NIX_LOG"
  echo "TERMINAL set to: $TERMINAL"

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
  };
}
