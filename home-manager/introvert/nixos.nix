{ config, ... }: { imports = [ 
  ../common 
  ./home.nix 
  ../apps/cli
  ];

apps = {
  cli = {
    zsh.enable = true;
    fzf.enable = false;
  };
};
}
