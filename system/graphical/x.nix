{ config, pkgs, ... }:

{
  import = [
    ./common.nix
  ];

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e";
    autorun = true;

    # Enable the Light Desktop Manager
    displayManager.lightdm.enable = true;

    desktopManager.wallpaper.mode = "fill";

    # Enable the KDE Desktop Environment.
    # displayManager.sddm.enable = true;
    # desktopManager.plasma5.enable = true;

    # Enable the GNOME Desktop Environment.
    # displayManager.gdm.enable = true;
    # desktopManager.gnome3.enable = true;
    # desktopManager.gnome3.default = "gnome3";

    # Enable XMonad
    # windowManager.xmonad.enable = true;

    displayManager.defaultSession = "xterm";
  };

}
