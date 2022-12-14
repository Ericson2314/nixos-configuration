{ config, ... }:

{
  imports = [
    ./emacs
    ./bash
    ./fish
    ./git
    ./haskell.nix
    ./home-manager.nix
    ./nixpkgs
    ./nvim
    ./misc-dev.nix
    ./secrets.nix
    ./aws.nix
    ./dark-mode.nix
  ];

  systemd.user.startServices = true;

  home.username = "jcericson";
  home.homeDirectory = "/home/${config.home.username}";
}
