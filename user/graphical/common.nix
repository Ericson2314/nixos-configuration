{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gimp
    #gimpPlugins.resynthesizer

    #hexchat

    #musescore

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

    haskellPackages.nix-diff

    telegram-desktop

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

  programs.firefox.enable = true;
}
