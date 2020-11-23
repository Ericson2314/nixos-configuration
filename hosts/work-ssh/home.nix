{ pkgs, ... }:

{
  imports = [
    ../../user
    ../../user/work.nix
  ];

  home.packages = with pkgs; [
    tig
  ];
}
