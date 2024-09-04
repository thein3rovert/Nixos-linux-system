{ pkgs, ...}:
{
  home.packages = with pkgs; [
    simplescreenrecorder
  ];
}
