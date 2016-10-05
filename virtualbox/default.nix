{ config, options, pkgs, ... }:

{
  imports = [
    ../common.nix
    ../../hardware-configuration.nix # Include the results of the hardware scan.
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "John-VirtualBox-NixOS"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    git
  ];

  users.users.john.extraGroups = [ "vboxsf" ];

  nix.nixPath = options.nix.nixPath.default ++ [
    ("ssh-config-file=${pkgs.writeText "ssh_config" ''
       Host github.com
       IdentityFile /etc/ssh/ssh_host_rsa_key
       StrictHostKeyChecking=no
     ''}")
  ];
}
