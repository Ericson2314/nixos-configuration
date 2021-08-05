{ ... }:

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
  ];

  systemd.user.startServices = true;
}
