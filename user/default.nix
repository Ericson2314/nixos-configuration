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
  ];

  systemd.user.startServices = true;
}
