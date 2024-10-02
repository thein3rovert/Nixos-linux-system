{ config, ... }: { imports = [ 
  ../common 
  ./home.nix 
  ../apps/cli
  ]

apps = {
  cli = {
    zsh.enable = false;
    fzf.enable = false;
  };
};
}
