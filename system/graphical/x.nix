{ config, pkgs, ... }:

{
  imports = [
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

    # Needed by home manager, workaround for
    # https://github.com/NixOS/nixpkgs/issues/70142
    # https://github.com/nix-community/home-manager/issues/1116
    desktopManager.xterm.enable = true;

    # Enable the Plasma 5 Desktop Environment.
    # displayManager.sddm.enable = true;
    # desktopManager.plasma5.enable = true;

    # Enable the GNOME Desktop Environment.
    # displayManager.gdm.enable = true;
    # desktopManager.gnome3.enable = true;

    # Enable XMonad
    # windowManager.xmonad.enable = true;

    displayManager.defaultSession = "xterm";
  };

}
