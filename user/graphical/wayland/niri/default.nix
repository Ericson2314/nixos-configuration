{
  config,
  inputs,
  pkgs,
  ...
}:

{
  xdg.portal.config.niri.default = [ "gtk" ];

  xdg.configFile."niri/config.kdl".source = ./config.kdl;

  home.packages = [
    pkgs.niri
  ];
}
