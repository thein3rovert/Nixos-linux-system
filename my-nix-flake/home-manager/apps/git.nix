{pkgs, ...}: {
 program.git.enable = true;
 program.git.userName = "thein3rovert";
 program.git.userEmail = "danielolaibi@gmail.com";
 home.packages = [ pkgs.gh ];
}
