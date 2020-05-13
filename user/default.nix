{ ... }:

{
  imports = [
    ./emacs
    ./fish
    ./git
    ./haskell.nix
    ./home-manager.nix
    ./nixpkgs
    ./nvim
    ./misc-dev.nix
  ];

  systemd.user.startServices = true;
}
