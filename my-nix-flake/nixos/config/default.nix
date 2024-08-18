{ config, pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./kernel.nix
  ];
}
