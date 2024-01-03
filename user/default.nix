{ config, pkgs, ... }:

{
  imports = [
    ./emacs
    ./bash
    ./fish
    ./git
    ./haskell.nix
    ./helix
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
  home.homeDirectory = "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/${config.home.username}";
}
