{ config, pkgs, ... }:

{
  imports = [
    ./boot-and-fs.nix
  ];

  networking.hostName = "John-Delphix-Nix";
}
