{ pkgs, ... }:

{
  programs.git.enable = true;
  programs.git.ignores = [
    "*~"
    "cabal.project.local"
    "dist-newstyle"
  ];
  # TODO maybe convert to structured.
  programs.git.extraConfig = builtins.readFile ./config;
  programs.git.package = pkgs.gitFull.override { guiSupport = true; };
}
