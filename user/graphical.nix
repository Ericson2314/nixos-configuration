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

    signal-desktop

    cabal-install
    haskellPackages.ghcid
    haskellPackages.nix-diff

    # browser
    # firefox done below
    chromium

    # Development
    (gitFull.override { guiSupport = true; })

    signal-desktop

    # Bits of Gnome
    # gnome3.gnome_terminal
    evince

    # Desktop Env
    dmenu
    #taffybar
  ];

  xsession.windowManager.xmonad = {
    enable = true;
    # TODO: Patch xmonad-contrib to fix
    # https://github.com/xmonad/xmonad-contrib/issues/280
    enableContribAndExtras = true;
    config = ./xmonad.hs;
    #extraPackages = p: with p; [ taffybar ];
  };

  programs.termite = {
    enable = true;
    scrollbackLines = -1;
  };

  xresources.properties = {
    "*.dpi" = 150;
  };

  programs.firefox.enable = true;

  xsession.pointerCursor = {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
  };

  services.redshift = {
    enable = true;
    provider = "geoclue2";
    # # New York
    # latitude = "40.7128";
    # longitude = "-74.0060";
    temperature.night = 1500;
    extraOptions = [ "-m randr" ];
  };
}
