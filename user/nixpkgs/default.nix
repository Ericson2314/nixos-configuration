{ options, ... }:

let
  nixpkgs-mozilla = ../../dep/nixpkgs-mozilla;
in

{
  nixpkgs.overlays = [
    (import ../../dep/nixpkgs-mozilla/rust-overlay.nix)
  ];
  xdg.configFile."nixpkgs/overlays/rust-overlay.nix".text = ''
    import ${nixpkgs-mozilla}/rust-overlay.nix
  '';

  xdg.configFile."nixpkgs/dep/nixpkgs-mozilla".source = nixpkgs-mozilla;

  nixpkgs.config = import ./config.nix;
  xdg.configFile."nixpkgs/config.nix".source =
    ./config.nix;
}
