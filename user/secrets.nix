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
    controlMaster = "auto";
    controlPath = "~/.ssh/master-%C";
    matchBlocks = {
      "bitbucket.com".user = "git";
      "bitbucket.org".user = "git";
      "github.com".user = "git";
      "gitlab.com".user = "git";
    };
  };
}
