{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  # Enable screensharing
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    gtkUsePortal = true;
  };
}
