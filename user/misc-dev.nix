{ pkgs, ... }:

{
  programs.jq.enable = true;

  home.packages = with pkgs; [
    nix-diff
  ];
}
