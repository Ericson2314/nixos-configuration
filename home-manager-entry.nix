import ./dep/home-manager/home-manager/home-manager.nix {
  pkgs = import ./dep/nixpkgs {};
  confPath = ~/.config/home-manager/home.nix;
}
