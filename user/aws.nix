{ pkgs, ... }:

{
  programs.ssh.settings."i-* mi-*" = {
    ProxyCommand = "aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'";
  };

  home.packages = with pkgs; [
    awscli2
    ssm-session-manager-plugin
  ];
}
