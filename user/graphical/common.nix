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

    element-desktop
    signal-desktop

    haskellPackages.nix-diff

    pavucontrol

    # browser
    # firefox done below
    chromium

    signal-desktop

    # Bits of Gnome
    # gnome3.gnome_terminal
    evince
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      scrollback.multiplier = -1;
      scrollback.faux_multiplier = -1;
    };
  };

  programs.firefox.enable = true;
}
