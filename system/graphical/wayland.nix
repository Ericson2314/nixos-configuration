{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  # Everything Wayland-specific is done in the user config now, including the
  # XDG portals for screensharing.
}
