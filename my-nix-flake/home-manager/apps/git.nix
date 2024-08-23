{ inputs, pkgs, ... }:

let 
  inherit (import ../../options.nix)
    gitUsername gitEmail;
in {

programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
  };
   home.packages = [ pkgs.gh ];
}
