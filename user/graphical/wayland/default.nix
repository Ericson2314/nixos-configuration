{
  lib,
  pkgs,
  config,
  options,
  ...
}:

{
  imports = [
    ../common.nix
    ./sway.nix
    ./niri
  ];

  # Enable screensharing
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config = {
      common.default = [ "*" ];
    };
  };

  xdg.configFile."sirula/config.toml".source = (pkgs.formats.toml { }).generate "sirula-config" {
    # Switch to left side
    anchor_left = true;
    anchor_right = false;
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  home.packages = with pkgs; [
    #swaylock
    #iswayidle
    wl-clipboard
    mako # notification daemon
    alacritty # Alacritty is the default terminal in the config
    wofi
    sirula # Launcher
  ];

  services.gammastep = import ../redshift.nix;
}
