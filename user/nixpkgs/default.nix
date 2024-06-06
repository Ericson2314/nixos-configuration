{ options, ... }:

{
  nixpkgs.overlays = [
    (import (import ../../dep/nixpkgs-mozilla/thunk.nix + "/rust-overlay.nix"))
  ];

  nixpkgs.config = import ./config.nix;
}
