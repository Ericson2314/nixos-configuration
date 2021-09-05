{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  # Enable the X11 windowing system.
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
    ];
    gtkUsePortal = true;
  };

}
