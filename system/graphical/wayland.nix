{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  # Enable screensharing
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
    ];
    gtkUsePortal = true;
  };
}
