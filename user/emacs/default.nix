{ pkgs, ... }:

{
  services.emacs.enable = true;
  programs.emacs.enable = true;
  programs.emacs.extraPackages = epkgs: with epkgs; [
    #agda2-mode

    (pkgs.emacsPackagesNg.trivialBuild {
      pname = "nix-docbook-mode";
      version = "1970-01-01";
      src = let
        schemas = pkgs.writeText "schemas.xml" ''
          <locatingRules xmlns="http://thaiopensource.com/ns/locating-rules/1.0">
            <documentElement localName="section" typeId="DocBook"/>
            <documentElement localName="chapter" typeId="DocBook"/>
            <documentElement localName="article" typeId="DocBook"/>
            <documentElement localName="book" typeId="DocBook"/>
            <typeId id="DocBook" uri="${pkgs.docbook5}/xml/rng/docbook/docbookxi.rnc" />
          </locatingRules>
        '';
      in pkgs.writeText "default.el" ''
        (eval-after-load 'rng-loc
          '(add-to-list 'rng-schema-locating-files "${schemas}"))
        (global-set-key (kbd "<C-return>") 'nxml-complete)
      '';
    })

    caml
    tuareg

    haskell-mode
    #structured-haskell-mode

    idris-mode
    nix-mode
    markdown-mode
    #rust-mode

    #scala-mode
    #sbt-mode

    #color-theme
    #color-theme-solarized

    dash
    #hexrgb
    #oneonone

    #ace-jump-mode
    #exec-path-from-shell
    flycheck
    #flycheck-pos-tip
    #gnus
    pkgs.aspell         # not emacs pkg
    pkgs.aspellDicts.en # not emacs pkg
    #magit
    #projectile
    #switch-window
    #smart-mode-line
    #undo-tree
    #use-package
  ];
  home.sessionVariables.EDITOR = "emacsclient --create-frame --tty";
  home.sessionVariables.VISUAL = "emacsclient --create-frame";

  home.file.".spacemacs".source = ./.spacemacs;
  home.file.".emacs.d/spacemacs".source = ../../dep/spacemacs;
  home.file.".emacs.d/init.el".text = ''
    (setq spacemacs-start-directory "~/.emacs.d/spacemacs/")
    (load-file (concat spacemacs-start-directory "init.el"))
  '';
}
