{ lib, pkgs, ... }:

let
  normal-keys = type: {
    space = {
      c = "toggle_comments";
      l.c = ":lsp-workspace-command";
      l.r = ":lsp-restart";
      l.s = ":lsp-stop";
      m.a = ":reload-all";
      m.c = ":config-reload";
      #m.f = ":yank-filepath-relative";
      #m.C-f = ":clipboard-yank-filepath-relative";
      m.r = ":reload";
      q.a = ":quit-all";
      q.C-a = ":quit-all!";
      q.q = ":quit";
      q.C-q = ":quit!";
      w.d = "wclose";
      space = "command_palette";
      ";" = "command_mode";
    };

    # Put old 'i' here
    f = "insert_mode";

    # Put old 'f' here
    h = "find_next_char";

    # 2nd player arrows
    i = "${type}_line_up";
    k = "${type}_line_down";
    j = "${type}_char_left";
    l = "${type}_char_right";

    C-c = "keep_primary_selection";
    "," = "toggle_comments";
  };

  # Common User Access
  # https://en.wikipedia.org/wiki/IBM_Common_User_Access
  cua = type: {
    "up" = "${type}_line_up";
    "down" = "${type}_line_down";
    "left" = "${type}_char_left";
    "right" = "${type}_char_right";
    "C-up" = "goto_prev_paragraph";
    "C-down" = "goto_next_paragraph";
    "C-left" = "${type}_prev_word_start";
    "C-right" = "${type}_next_word_start";
  };

in {
  programs.helix.enable = true;
  programs.helix.defaultEditor = true;

  #programs.helix.package = pkgs.helix.overrideAttrs {
  #  src = source.helix;
  #};

  programs.helix.settings = {
    theme = "github_dark";

    editor.color-modes = true;
    editor.idle-timeout = 100;
    editor.lsp.display-messages = true;
    editor.soft-wrap.enable = true;
    editor.true-color = true;
    #editor.whitespace.render = "trailing";

    editor.cursor-shape = {
      insert = "bar";
      select = "bar";
    };

    keys.normal = normal-keys "move"
      // cua "move"
      // lib.mapAttrs'
        (name: value: lib.nameValuePair ("S-" + name) value)
        (cua "extend");
    keys.select = normal-keys "extend"
      // cua "extend";

    keys.insert = {
      C-c = "normal_mode";
    };
  };

  programs.helix.languages = {
    language-server = {
      pyright = {
        command = "pyright-langserver";
        args = [ "--stdio" ];
        config = {};
      };
    };
    language = [
      {
        name = "python";
        language-servers = ["pyright"];
      }
    ];
  };

  home.packages = [
    pkgs.nil
    pkgs.nodePackages.bash-language-server
    #pkgs.nodePackages.dockerfile-language-server-nodejs
    pkgs.nodePackages.typescript-language-server
    pkgs.pyright
  ];
}
