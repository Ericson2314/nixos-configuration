{ ... }:

{
  nixpkgs.config = import ./config.nix;
  xdg.configFile."nixpkgs/config.nix".source =
      ./config.nix;
}
