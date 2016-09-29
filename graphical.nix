{ config, pkgs, ... }:

{
  nixpkgs.config.firefox = {
    #enableGnomeExtensions = true;
    #enableGoogleTalkPlugin = true;
    enableAdobeFlash = true;
  };

  environment.systemPackages = with pkgs; [
    # Browser
    firefox

    # Development
    (git.override { guiSupport = true; })

    # Desktop Env
    dmenu

    # Bits of Gnome
    # gnome3.gnome_terminal
    evince

    # Terminal emulator
    termite
  ];

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e";
    autorun = true;

    # Enable the Light Desktop Manager
    displayManager.lightdm.enable = true;

    # Enable the KDE Desktop Environment.
    # displayManager.kdm.enable = true;
    # desktopManager.kde4.enable = true;

    # Enable the GNOME Desktop Environment.
    # displayManager.gdm.enable = true;
    # desktopManager.gnome3.enable = true;
    # desktopManager.gnome3.default = "gnome3";

    # Enable XMonad
    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;
    windowManager.default = "xmonad";
    desktopManager.default = "none";
  };
}
