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
    settings = {
      "*" = {
        ControlMaster = "auto";
        ControlPath = "~/.ssh/master-%C";
      };
      "bitbucket.com".User = "git";
      "bitbucket.org".User = "git";
      "github.com".User = "git";
      "gitlab.com".User = "git";
    };
  };
}
