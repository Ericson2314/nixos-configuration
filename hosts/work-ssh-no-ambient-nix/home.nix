{ config, ... }:

{
  imports = [
    ../work-ssh/home.nix
  ];

  programs.bash.profileExtra = ''
    if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
      . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    fi

    # Until the above stops setting it, set again
    export NIX_PATH=${config.home.sessionVariables.NIX_PATH}
  '';

  home.sessionVariables.NIX_PATH = "nixpkgs=${config.home.homeDirectory}/src/nixos-configuration/dep/nixpkgs";
}
