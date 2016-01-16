{ config, pkgs, ... }:

{
  imports = [
    ../common.nix
    ./boot-and-fs.nix
    ./wireless.nix
  ];

  networking.hostName = "John-Delphix-Nix";
}
