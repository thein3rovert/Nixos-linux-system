{ config, pkgs, ... }:  # Function arguments: config and pkgs are passed in, along with any other arguments
let
  calender = false;  # Define a variable 'calender' and set it to true
in
{
  home.packages = with pkgs;  # Use the 'pkgs' attribute set
    (if calender then [ morgen ] else []);  # If 'calender' is true, include 'morgen' in the home packages, otherwise include an empty list
}
