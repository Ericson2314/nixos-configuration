{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gimp
    #gimpPlugins.resynthesizer

    #hexchat
    thunderbird

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

    signal-desktop

    haskellPackages.nix-diff

    # browser
    # firefox done below
    chromium

    signal-desktop

    # Bits of Gnome
    # gnome3.gnome_terminal
    evince

    # Desktop Env
    dmenu
  ];

  xsession = {
    enable = true;

    windowManager.xmonad = {
      enable = true;
      # TODO: Patch xmonad-contrib to fix
      # https://github.com/xmonad/xmonad-contrib/issues/280
      enableContribAndExtras = true;
      config = ./xmonad.hs;
      extraPackages = p: with p; [ taffybar ];
    };
    pointerCursor = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
    };
  };

  services.taffybar.enable = true;
  xdg.configFile."taffybar/taffybar.hs".source = ./taffybar.hs;

  programs.termite = {
    enable = true;
    scrollbackLines = -1;
  };

  xresources.properties = {
    # A nice desktop size
    #"*.dpi" = 120;
    # A nice laptop size:
    #"*.dpi" = 150;
    # Double pixels:
    #"*.dpi" = 192;
  };

  programs.firefox.enable = true;

  services.redshift = {
    enable = true;
    provider = "manual";
    #provider = "geoclue2";
    # New York
    latitude = "40.7128";
    longitude = "-74.0060";
    temperature.night = 1500;
    #extraOptions = [ "-m randr" ];
  };
}
