{pkgs, ...}: {
  imports = [
    ./zsh.nix
    ./fzf.nix
  ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
#    extraOptions = ["-l" "--icons" "--git" "-a"]; -- Disable icon for eza
    extraOptions = ["-l" ]; #Icon has been disabled 
    
  };

  programs.bat = {enable = true;};

  home.packages = with pkgs; [
    coreutils
    fd
    htop
    httpie
    jq
    procs
    ripgrep
    tldr
    zip
  ];
}
