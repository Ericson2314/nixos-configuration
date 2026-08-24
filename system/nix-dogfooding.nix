{ lib, pkgs, ... }:

let
  nixSrc = import ../dep/nix/thunk.nix;

  nixDependencies = lib.makeScope pkgs.newScope (
    import (nixSrc + "/packaging/dependencies.nix") {
      inherit pkgs;
      inherit (pkgs) stdenv;
      inputs = { };
    }
  );

  nixComponents = lib.makeScope nixDependencies.newScope (
    import (nixSrc + "/packaging/components.nix") {
      officialRelease = false;
      inherit lib pkgs;
      src = nixSrc;
      maintainers = [ ];
    }
  );
in
{
  # Dogfooding master! 🫡
  nix.package = nixComponents.nix-cli;

  # Want to use the new containers tests
  nix.settings.extra-experimental-features = [
    "auto-allocate-uids"
    "cgroups"
  ];
  nix.settings.auto-allocate-uids = true;
  nix.settings.use-cgroups = true;
  nix.settings.extra-system-features = [ "uid-range" ];
}
