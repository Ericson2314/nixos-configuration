{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../graphical.nix
    ../synaptics.nix
    ./wireless.nix
    ./touchpad.nix
  ];

  networking.hostName = "John-2006-NixOS";

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.03";

  nix.maxJobs = 2;
}
