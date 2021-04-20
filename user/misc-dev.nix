{ pkgs, ... }:

{
  programs.jq.enable = true;

  home.packages = with pkgs; [
    nix-diff
    nodejs-14_x
    #nodePackages.npm
    nodePackages.yarn
  ];
}
