{ ... }:

{
  imports = [
    ./emacs
    ./fish
    ./git
    ./home-manager.nix
    ./graphical.nix
    ./nvim
  ];

  systemd.user.startServices = true;
}
