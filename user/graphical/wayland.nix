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
      menu     = "sirula";

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
    systemd.enable = true;
  };

  xdg.configFile."sirula/config.toml".source = (pkgs.formats.toml {}).generate "sirula-config" {
    # Switch to left side
    anchor_left = true;
    anchor_right = false;
  };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  home.packages = with pkgs; [
    #swaylock
    #iswayidle
    wl-clipboard
    mako # notification daemon
    alacritty # Alacritty is the default terminal in the config
    wofi
    sirula # Launcher
    niri # Considering using instead of Sway
  ];

  services.gammastep = import ./redshift.nix;
}
