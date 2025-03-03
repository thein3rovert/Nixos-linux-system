{ pkgs, ... }:
{
  imports = [
    ./zsh.nix
    ./fzf.nix
    ./htop.nix
    ./git.nix
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
    extraOptions = [ "-l" ]; # Icon has been disabled

  };

  programs.bat = {
    enable = true;
  };

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

    #   Music
    cmus

    ##  Important files for neovim config
    lua-language-server
    lua51Packages.lua
    gccgo14
    luajitPackages.luarocks
    tree-sitter
    vimPlugins.luasnip
    python312Packages.pip
    prettierd
    unzip
    luajitPackages.jsregexp
    slides
    just
    cargo
    nil # Used for my lua-language-server

    #   Addtional Cli tools
    #    rainfrog --cant find on nixos packages
    #    lazydocker #delete from configuration.nix
    #
    # Terminal Based Typing Test
    toipe
    tt
  ];
}
