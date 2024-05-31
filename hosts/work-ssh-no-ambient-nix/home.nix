{ config, ... }:

{
  imports = [
    ../work-ssh/home.nix
  ];

  programs.bash.profileExtra = ''
    if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
      . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    fi
  '';
}
