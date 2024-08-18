{ inputs, pkgs, ... }:

let 
  inherit (import ../options.nix)
    gitUsername gitEmail;
in {
 program.git.enable = true;
 program.git.userName = "${gitUsername}";
 program.git.userEmail = "${gitEmail}";
 home.packages = [ pkgs.gh ];
}
