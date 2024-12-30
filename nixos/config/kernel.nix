{ config, ... }:

{
  imports = [
    ./kernel/default.nix
    ./kernel/latest.nix
    ./kernel/lqx.nix
    ./kernel/zen.nix
    
    # For the adventurous people
    # It's not listed in the list of possible options, 
  ];
}
