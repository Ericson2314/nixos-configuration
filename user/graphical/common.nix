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

    pavucontrol

    # Bits of Gnome
    # gnome3.gnome_terminal
    evince
  ];

  home.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
  };

  programs.alacritty = {
    enable = true;
    settings = {
      scrollback.multiplier = -1;
      scrollback.faux_multiplier = -1;
    };
  };

  programs.firefox.enable = true;
}
