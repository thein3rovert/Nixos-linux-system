{ pkgs, config, lib, ... }:

{
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

}
