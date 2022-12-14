{ pkgs, ... }:

{
  imports = [
    ../../user
    ../../user/work.nix
  ];

  home.packages = with pkgs; [
    tig
  ];

  home.stateVersion = "22.05";
}
