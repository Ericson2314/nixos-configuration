{ lib, pkgs, ... }:

let
  hydraSrc = import ../dep/hydra/thunk.nix;

  # Hydra's other inputs come straight out of its lockfile, so there is
  # exactly one thing to bump. nixpkgs is deliberately *not* taken from
  # there: hydra builds against this machine's nixpkgs.
  lock = builtins.fromJSON (builtins.readFile (hydraSrc + "/flake.lock"));
  lockedSrc =
    name:
    let
      l = lock.nodes.${name}.locked;
    in
    pkgs.fetchgit {
      url = "https://github.com/${l.owner}/${l.repo}";
      inherit (l) rev;
      hash = l.narHash;
    };

  # Hydra builds against its own pinned Nix (2.35-maintenance), not the
  # master Nix that `nix-dogfooding.nix` puts on the system.
  nixSrc = lockedSrc "nix";

  # Mirrors `mkNixDependencies` in hydra's flake.nix, including its
  # boost patch workaround.
  nixDependencies = lib.makeScope pkgs.newScope (
    scope:
    let
      super = import (nixSrc + "/packaging/dependencies.nix") {
        inherit pkgs;
        inherit (pkgs) stdenv;
        inputs = { };
      } scope;
    in
    super
    // {
      boost = super.boost.overrideAttrs (_: {
        patches = pkgs.boost.patches;
      });
    }
  );

  nixComponents = lib.makeScope nixDependencies.newScope (
    import (nixSrc + "/packaging/components.nix") {
      officialRelease = true;
      inherit lib pkgs;
      src = nixSrc;
      maintainers = [ ];
    }
  );

  craneLib = import (lockedSrc "crane") { inherit pkgs; };

  version = lib.strings.trim (builtins.readFile (hydraSrc + "/version.txt"));

  # Mirrors `mkHydraComponents` in hydra's flake.nix.
  hydraComponents = lib.makeScope nixDependencies.newScope (
    import (hydraSrc + "/packaging/components.nix") {
      inherit version craneLib nixComponents;
      releaseVersion = "${version}.dogfood";
      nix-eval-jobs-src = lockedSrc "nix-eval-jobs";
      rawSrc = hydraSrc;
    }
  );

  # The modules look their packages up per system, as a flake would.
  hydraModules = import (hydraSrc + "/nixos-modules") {
    flakePackages.${pkgs.stdenv.hostPlatform.system} = hydraComponents;
  };
in
{
  # web-app, queue-runner, builder, ws-server and the optional ad-hoc
  # daemon, all on this one machine.
  imports = [ hydraModules.hydra ];

  services.postgresql.enable = true;

  # The default is chosen from `system.stateVersion`, which on some
  # hosts maps to a PostgreSQL that nixpkgs has since removed. Fresh
  # database, so just take the current one.
  services.postgresql.package = pkgs.postgresql;

  services.hydra-dev = {
    enable = true;
    hydraURL = "http://localhost:3000";
    notificationSender = "hydra@localhost";
  };

  services.hydra-queue-runner-dev.enable = true;

  services.hydra-queue-builder-dev = {
    enable = true;
    queueRunnerAddr = "http://[::1]:50051";
  };

  # Dogfooding ad hoc jobs: the socket is group `hydra`, mode 0660, so
  # a member of that group can point a client at it with
  #
  #   NIX_REMOTE=unix:///run/hydra-ad-hoc/socket nix-store --realise ./foo.drv
  #
  # and have Hydra's queue runner and builder do the build.
  services.hydra-ad-hoc-dev.enable = true;
  users.users.jcericson.extraGroups = [ "hydra" ];

  # Chatty logs while this is being shaken out.
  systemd.services.hydra-ad-hoc-dev.environment.RUST_LOG = "debug";
  systemd.services.hydra-queue-builder-dev.environment.RUST_LOG = "debug";
}
