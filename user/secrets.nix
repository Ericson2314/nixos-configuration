{ pkgs, ... }:

{
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = pkgs.stdenv.isLinux;
    enableSshSupport = true;
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        controlMaster = "auto";
        controlPath = "~/.ssh/master-%C";
      };
      "bitbucket.com".user = "git";
      "bitbucket.org".user = "git";
      "github.com".user = "git";
      "gitlab.com".user = "git";
    };
  };
}
