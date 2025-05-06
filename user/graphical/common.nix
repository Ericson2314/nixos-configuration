{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gimp
    #gimpPlugins.resynthesizer

    #hexchat

    #musescore

    libreoffice
    dbeaver-bin
    meld

    qemu
    gdb

    ncdu
    #unison_2_40
    htop

    xsel

    p7zip
    unzip
    unrar

    chromium

    thunderbird

    element-desktop
    signal-desktop
    telegram-desktop

    haskellPackages.nix-diff

    pavucontrol

    # Bits of Gnome
    # gnome3.gnome_terminal
    evince

    zoom-us
  ];

  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
  };

  programs.alacritty = {
    enable = true;
  };

  home.sessionVariables = {
    TERMINAL = "alacritty";
  };

  programs.firefox.enable = true;
}
