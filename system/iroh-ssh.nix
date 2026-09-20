{ lib, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.iroh-ssh
  ];

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
