{ pkgs, ... }:

{
  imports = [
    ../../user
    ../../user/work.nix
    ../../user/textual.nix
  ];

  home.packages = with pkgs; [
    tig
  ];

  home.stateVersion = "22.05";
}
