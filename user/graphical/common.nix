{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gimp
    #gimpPlugins.resynthesizer

    #hexchat
    thunderbird

    #musescore

    vscode

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

    signal-desktop

    haskellPackages.nix-diff

    pavucontrol

    # browser
    # firefox done below
    chromium

    signal-desktop

    # Bits of Gnome
    # gnome3.gnome_terminal
    gnome3.bijiben
    evince

    # Desktop Env
    dmenu
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      scrollback.multiplier = -1;
      scrollback.faux_multiplier = -1;
    };
  };

  programs.firefox.enable = true;

  # services.redshift = {
  #   enable = true;
  #   provider = "manual";
  #   #provider = "geoclue2";
  #   # South of New York, for less seasonal variation
  #   latitude = "27";
  #   longitude = "-74.0060";
  #   #longitude = "-122.4194"; # San Francisco
  #   temperature.night = 1500;
  #   #extraOptions = [ "-m randr" ];
  # };
}
