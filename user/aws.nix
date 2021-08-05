{ pkgs, ... }:

{
  programs.ssh.matchBlocks."i-* mi-*" = {
    proxyCommand = "aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'";
  };

  home.packages = with pkgs; [
    awscli
    ssm-session-manager-plugin
  ];
}
