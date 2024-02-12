{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  # Enable screensharing
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config = {
      common.default = [ "gtk" ];
      sway.default = [ "gtk" "wlr" ];
    };
    wlr = {
      enable = true;
      settings = {
        screencast = {
          Max_fps = 60;
          #Output_name = "DP-1";
          Chooser_type = "default";
        };
      };
    };
  };
}
