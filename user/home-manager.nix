{ pkgs, ... }:

{
  home.packages = [
    # TODO: Consider using nixpkgs version once it's more stable/up-to-date.
    (import ../dep/home-manager { inherit pkgs; }).home-manager
  ];
}
