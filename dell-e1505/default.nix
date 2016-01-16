{ config, pkgs, ... }:

{
  imports = [
    ./boot-and-fs.nix
    ./wireless.nix
    ./touchpad.nix
  ];

  networking.hostName = "John-Laptop-Nix";

  nix.maxJobs = 2;
}
