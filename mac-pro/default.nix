{ config, pkgs, ... }:

{
  imports = [
    ./boot-and-fs.nix
    ./wireless.nix
  ];

  networking.hostName = "John-Delphix-Nix";
}
