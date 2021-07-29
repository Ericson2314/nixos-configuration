{ ... }:

{
  programs.gpg = {
    enable = true;
  };

  services.gpg-agent = {
    enable = true;
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
