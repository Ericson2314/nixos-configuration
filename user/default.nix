{ ... }:

{
  imports = [
    ./emacs
    ./fish
    ./git
    ./haskell.nix
    ./home-manager.nix
    ./graphical.nix
    ./nixpkgs
    ./nvim
  ];

  systemd.user.startServices = true;
}
