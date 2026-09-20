{ lib, pkgs, ... }:

# SSH in over iroh without a public IP; upstream has no NixOS module yet.
# Log in as a real user (`iroh-ssh jcericson@<id>`), not the one in the banner.
{
  systemd.services.iroh-ssh-server = {
    description = "SSH over Iroh";
    wantedBy = [ "multi-user.target" ];
    after = [
      "network-online.target"
      "sshd.service"
    ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      DynamicUser = true;
      StateDirectory = "iroh-ssh";
      ExecStart = lib.escapeShellArgs [
        (lib.getExe pkgs.iroh-ssh)
        "server"
        "--persist"
        "--key-dir"
        "/var/lib/iroh-ssh"
        "--ssh-port"
        "22"
      ];
      Restart = "on-failure";
      RestartSec = "3s";
    };
  };
}
