{ pkgs, inputs, ... }:

{
  # List System Programs
  environment.systemPackages = with pkgs; [
    maven
  ];
}
