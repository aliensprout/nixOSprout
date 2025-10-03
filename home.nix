{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/.dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    qtile = "qtile";
    nvim = "nvim";
    alacritty = "alacritty";
    rofi = "rofi";
    picom = "picom";
  };
in

{
  home.username = "wes";
  home.homeDirectory = "/home/wes";
  home.stateVersion = "25.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      sprout = "echo I am running on alienOSprout";
      nrs = "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/.dotfiles#aliensprout";
    };
    initExtra = ''
      export PS1="\[\e[38;5;212m\]\u@\h \[\e[38;5;140m\]\w \[\e[38;5;206m\]\$ \[\e[0m\]"
    '';
  };

  programs.git = {
    enable = true;
    userName = "aliensprout";
    userEmail = "230080509+aliensprout@users.noreply.github.com";
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;


  #   xdg.configFile."qtile" = { 
  #       source = create_symlink "${dotfiles}/qtile/";
  #       recursive = true;
  #   };

  #   xdg.configFile."nvim" = { 
  #       source = create_symlink "${dotfiles}/nvim/";
  #       recursive = true;
  #   };

  #   xdg.configFile."alacritty" = { 
  #       source = create_symlink "${dotfiles}/alacritty/";
  #       recursive = true;
  #   };

  home.packages = with pkgs; [
    neovim
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    rofi
    xwallpaper
  ];

}

