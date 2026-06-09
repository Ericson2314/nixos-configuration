{ pkgs, ... }:

{
  programs.jq.enable = true;

  home.packages = with pkgs; [
    nix-diff
    # I don't use it a lot, but Claude does!
    gh
  ];
}
