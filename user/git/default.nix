{ pkgs, lib, ... }:

{
  programs.git.enable = true;
  programs.git.ignores = [
    "*~"
    "cabal.project.local"
    "dist-newstyle"
  ];

  # TODO multiple "insteadOf"
  programs.git.userName = "John Ericson";

  # Need to override on work machines
  programs.git.userEmail = lib.mkDefault "git@JohnEricson.me";

  programs.git.iniContent = {
    "push" = {
      default = "simple";
    };
    "merge" = {
      conflictstyle = "diff3";
    };
    "rerere" = {
      enabled = true;
    };
    "url \"ssh://git@gist.github.com\"" = {
      insteadOf = git://gist.github.com;
      #insteadOf = https://gist.github.com;
      #insteadOf = http://gist.github.com;
    };
    "url \"ssh://git@github.com\"" = {
      insteadOf = git://github.com;
      #insteadOf = https://github.com;
      #insteadOf = http://github.com;
    };
    "url \"ssh://git@gitlab.com\"" = {
      insteadOf = git://gitlab.com;
      #insteadOf = https://gitlab.com;
      #insteadOf = http://gitlab.com;
    };
    "url \"ssh://git@bitbucket.com\"" = {
      insteadOf = git://bitbucket.com;
      #insteadOf = https://bitbucket.com;
      #insteadOf = http://bitbucket.com;
    };
  };
  programs.git.package = pkgs.gitFull.override { guiSupport = true; };
}
