{ pkgs, ... }: {
  home.packages = with pkgs; [ xdg-utils ];

  xdg.userDirs = {
      enable = true;
      desktop = "$HOME";
      download = "$HOME/Downloads";
      documents = "$HOME/documents";
      pictures = "$HOME/pictures";
      videos = "$HOME/videos";
    };
}
