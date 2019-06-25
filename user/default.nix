{ ... }:

{
  imports = [
    ./emacs
    ./fish
    ./git
    ./home-manager.nix
    ./graphical.nix
    ./nixpkgs
    ./nvim
  ];

  systemd.user.startServices = true;
}
