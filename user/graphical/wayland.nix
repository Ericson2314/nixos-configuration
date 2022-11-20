{ lib, pkgs, config, options, ... }:

{
  imports = [
    ./common.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true; # so that gtk works properly
    config = {
      terminal = "alacritty";
      menu     = "bemenu-run";

      up       = "i";
      down     = "k";
      left     = "j";
      right    = "l";

      modifier = "Mod4";

      output = {
        "eDP-1" = {
          scale = "1";
        };
      };

      floating.criteria = [
        {
          "title" = "Firefox — Sharing Indicator";
        }
      ];

      window.commands = [
        {
          criteria = {
            "title" = "Firefox — Sharing Indicator";
          };
          command = "nofocus";
        }
      ];

      keybindings = let
        cfg = config.wayland.windowManager.sway;
      in lib.mkOptionDefault {
        "${cfg.config.modifier}+Shift+Return" = "exec ${cfg.config.terminal}";
        "${cfg.config.modifier}+Shift+c" = "kill";
        "${cfg.config.modifier}+p" = "exec ${cfg.config.menu}";
        "${cfg.config.modifier}+q" = "reload";
        "${cfg.config.modifier}+a" = "exec autorandr -c";
        "${cfg.config.modifier}+s" = "exec systemctl suspend";
        "${cfg.config.modifier}+d" = "exec physlock";
        "${cfg.config.modifier}+f" = "exec emacsclient --create-frame";
        "${cfg.config.modifier}+Shift+q" =
          "exec swaynag -t warning -m 'Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
        "${cfg.config.modifier}+0" = "workspace number 10";
        "${cfg.config.modifier}+Shift+0" =
            "move container to workspace number 10";
      };
    };
    systemdIntegration = true;
  };

  programs.firefox.package = pkgs.firefox-wayland;

  home.packages = let
    forceWayland = t: e: f: pkgs.stdenv.mkDerivation {
       pname = t.pname or t.name + "-force-wayland";
       inherit (t) version;
       unpackPhase = "true";
       doBuild = false;
       nativeBuildInputs = [ pkgs.buildPackages.makeWrapper ];
       installPhase = ''
         mkdir -p $out/bin
         ln -s "${lib.getBin t}/bin/${e}" "$out/bin"
       '';
       postFixup = ''
         for e in $out/bin/*; do
           wrapProgram $e ${f}
         done
       '';
    };
  in with pkgs; [
    #swaylock
    #iswayidle
    wl-clipboard
    mako # notification daemon
    alacritty # Alacritty is the default terminal in the config
    wofi
    bemenu
    (forceWayland thunderbird "thunderbird" "--set-default MOZ_ENABLE_WAYLAND 1")
    (forceWayland chromium "chromium" "--add-flags '--enable-features=UseOzonePlatform --ozone-platform=wayland'")
    (forceWayland signal-desktop "signal-desktop" "--add-flags '--enable-features=UseOzonePlatform --ozone-platform=wayland'")
    (forceWayland element-desktop "element-desktop" "--add-flags '--enable-features=UseOzonePlatform --ozone-platform=wayland'")
  ];

  services.gammastep = import ./redshift.nix;
}
