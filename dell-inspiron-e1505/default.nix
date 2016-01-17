{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ./boot-and-fs.nix
    ./wireless.nix
    ./touchpad.nix
  ];

  networking.hostName = "John-2006-NixOS";

  nix.maxJobs = 2;
}
