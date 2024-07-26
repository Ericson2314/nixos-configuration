{ pkgs, ... }:

{
  home.packages = with pkgs; [
    alacritty.terminfo
  ];

  home.sessionVariables = {
    TERMINFO_DIRS = "\${HOME}/.nix-profile/share/terminfo:\${TERMINFO_DIRS}";
  };
}
