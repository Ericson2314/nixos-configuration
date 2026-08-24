{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  # `wayland.windowManager.niri` isn't in home manager 26.05 yet, so fetch just
  # that one module from master for now. It only needs `lib.hm.generators.toKDL`
  # and `lib.hm.assertions.assertPlatform`, both of which 26.05 already has.
  #
  # Delete this once we're on a home manager release that ships the module.
  niri-module = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/nix-community/home-manager/f404edbfa4117810c96b97048299242fc50e5362/modules/services/window-managers/niri.nix";
    sha256 = "1p9b5cq4xbsi16m1iah0v4a8q2zyqybfkd3rfh1h8bqi376mhgkc";
  };

  # `Mod` focuses, `Mod+Shift` moves the column/window, `Mod+Ctrl` acts on
  # monitors. Upstream has `Shift` and `Ctrl` the other way around.
  arrows = {
    Left = {
      focus = "focus-column-left";
      move = "move-column-left";
    };
    Right = {
      focus = "focus-column-right";
      move = "move-column-right";
    };
    Up = {
      focus = "focus-window-up";
      move = "move-window-up";
    };
    Down = {
      focus = "focus-window-down";
      move = "move-window-down";
    };
  };

  arrowBinds = lib.mergeAttrsList (
    lib.mapAttrsToList (key: action: {
      "Mod+${key}"."${action.focus}" = { };
      "Mod+Shift+${key}"."${action.move}" = { };
      "Mod+Ctrl+${key}"."focus-monitor-${lib.toLower key}" = { };
      "Mod+Ctrl+Shift+${key}"."move-column-to-monitor-${lib.toLower key}" = { };
    }) arrows
  );

  workspaceBinds = lib.mergeAttrsList (
    map (n: {
      "Mod+${toString n}".focus-workspace = n;
      "Mod+Shift+${toString n}".move-column-to-workspace = n;
    }) (lib.range 1 9)
  );

in

{
  imports = [
    niri-module
  ];

  wayland.windowManager.niri = {
    enable = true;

    settings = {
      # Only focus windows already fully on screen.
      input.focus-follows-mouse._props.max-scroll-amount = "0%";

      # Tell clients they are tiled, so they drop their own decorations.
      prefer-no-csd = { };

      layout.preset-column-widths._children = [
        # My additions
        { proportion = 0.16666; }
        { proportion = 0.2; }
        { proportion = 0.25; }
        # niri's three presets
        { proportion = 0.33333; }
        { proportion = 0.5; }
        { proportion = 0.66667; }
      ];

      binds =
        arrowBinds
        // workspaceBinds
        // {
          "Mod+Shift+Slash".show-hotkey-overlay = { };

          "Mod+Return" = {
            _props.hotkey-overlay-title = "Open a Terminal: alacritty";
            spawn = [ "alacritty" ];
          };
          "Mod+Shift+Return" = {
            _props.hotkey-overlay-title = "Open a Terminal: alacritty";
            spawn = [ "alacritty" ];
          };
          "Mod+P" = {
            _props.hotkey-overlay-title = "Spawn a process: sirula";
            spawn = [ "sirula" ];
          };

          "Mod+O" = {
            _props.repeat = false;
            toggle-overview = { };
          };
          "Mod+Q" = {
            _props.repeat = false;
            close-window = { };
          };

          # Most of the following is because I want to swap Control and
          # Shift from Niri's defaults, because of my personal habits
          # going back to Sway and XMonad. This is just a very verbose
          # way of (a) re-encoding Niri's defaults in home manager (b)
          # swapping those keys.

          "Mod+Home".focus-column-first = { };
          "Mod+End".focus-column-last = { };
          "Mod+Shift+Home".move-column-to-first = { };
          "Mod+Shift+End".move-column-to-last = { };

          "Mod+Page_Down".focus-workspace-down = { };
          "Mod+Page_Up".focus-workspace-up = { };
          "Mod+Shift+Page_Down".move-column-to-workspace-down = { };
          "Mod+Shift+Page_Up".move-column-to-workspace-up = { };
          "Mod+Ctrl+Page_Down".move-workspace-down = { };
          "Mod+Ctrl+Page_Up".move-workspace-up = { };

          "Mod+WheelScrollDown" = {
            _props.cooldown-ms = 150;
            focus-workspace-down = { };
          };
          "Mod+WheelScrollUp" = {
            _props.cooldown-ms = 150;
            focus-workspace-up = { };
          };
          "Mod+Ctrl+WheelScrollDown" = {
            _props.cooldown-ms = 150;
            move-column-to-workspace-down = { };
          };
          "Mod+Ctrl+WheelScrollUp" = {
            _props.cooldown-ms = 150;
            move-column-to-workspace-up = { };
          };

          "Mod+WheelScrollRight".focus-column-right = { };
          "Mod+WheelScrollLeft".focus-column-left = { };
          "Mod+Ctrl+WheelScrollRight".move-column-right = { };
          "Mod+Ctrl+WheelScrollLeft".move-column-left = { };

          # Scrolling with Shift is horizontal scrolling in most applications.
          "Mod+Shift+WheelScrollDown".focus-column-right = { };
          "Mod+Shift+WheelScrollUp".focus-column-left = { };
          "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = { };
          "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = { };

          "Mod+Tab".focus-workspace-previous = { };

          "Mod+BracketLeft".consume-or-expel-window-left = { };
          "Mod+BracketRight".consume-or-expel-window-right = { };
          "Mod+Comma".consume-window-into-column = { };
          "Mod+Period".expel-window-from-column = { };

          "Mod+R".switch-preset-column-width = { };
          "Mod+Shift+R".switch-preset-column-width-back = { };
          "Mod+Ctrl+Shift+R".switch-preset-window-height = { };
          "Mod+Ctrl+R".reset-window-height = { };

          "Mod+F".maximize-column = { };
          "Mod+Ctrl+F".fullscreen-window = { };
          "Mod+M".maximize-window-to-edges = { };
          "Mod+Shift+F".expand-column-to-available-width = { };

          "Mod+C".center-column = { };
          "Mod+Shift+C".center-visible-columns = { };

          "Mod+Minus".set-column-width = "-10%";
          "Mod+Equal".set-column-width = "+10%";
          "Mod+Shift+Minus".set-window-height = "-10%";
          "Mod+Shift+Equal".set-window-height = "+10%";

          "Mod+V".toggle-window-floating = { };
          "Mod+Ctrl+V".switch-focus-between-floating-and-tiling = { };
          "Mod+W".toggle-column-tabbed-display = { };

          Print.screenshot = { };
          "Ctrl+Print".screenshot-screen = { };
          "Alt+Print".screenshot-window = { };

          "Mod+Escape" = {
            _props.allow-inhibiting = false;
            toggle-keyboard-shortcuts-inhibit = { };
          };

          "Mod+Ctrl+E".quit = { };
          "Ctrl+Alt+Delete".quit = { };
          "Mod+Ctrl+P".power-off-monitors = { };
        };
    };
  };
}
