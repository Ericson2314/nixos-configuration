let
  projectsRoot = "/home/john/Code/git/";

  clashProjects = self: super: let
      clashRoot            = projectsRoot + "clash/";
    in {
      wl-pprint-text-class = self.callPackage (clashRoot + "wl-pprint-text-class") {};

      clash-lib            = self.callPackage (clashRoot + "clash2/clash-lib") {};
      clash-vhdl           = self.callPackage (clashRoot + "clash2/clash-vhdl") {};
      clash-systemverilog  = self.callPackage (clashRoot + "clash2/clash-verilog") {};
      clash-ghc            = self.callPackage (clashRoot + "clash2/clash-ghc") {};

      verilog-ast          = self.callPackage (clashRoot + "verilog/ast") {};
      verilog-pretty-print = self.callPackage (clashRoot + "verilog/pretty-print") {};
  };

  cncProjects = self: super: let
      cncRoot  = projectsRoot + "cnc/";
    in {
      petool   = self.callPackage (cncRoot + "petool") {};
      engine1  = self.callPackage (cncRoot + "engine1") {};
      engine2  = self.callPackage (cncRoot + "engine2") {};
      dune2k   = self.callPackage (cncRoot + "dune2k") {};
  };
in
{
  allowUnfree = true;

  packageOverrides = super: let self = super.pkgs; in {
    myEmacs = self.emacsPackagesNg.emacsWithPackages (epkgs: with epkgs; [
      agda2-mode

      (self.emacsPackagesNg.trivialBuild {
        pname = "nix-docbook-mode";
        version = "1970-01-01";
        src = let
          schemas = self.writeText "schemas.xml" ''
            <locatingRules xmlns="http://thaiopensource.com/ns/locating-rules/1.0">
              <documentElement localName="section" typeId="DocBook"/>
              <documentElement localName="chapter" typeId="DocBook"/>
              <documentElement localName="article" typeId="DocBook"/>
              <documentElement localName="book" typeId="DocBook"/>
              <typeId id="DocBook" uri="${self.docbook5}/xml/rng/docbook/docbookxi.rnc" />
            </locatingRules>
          '';
        in self.writeText "default.el" ''
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
      #nix-mode
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
      self.aspell         # not emacs pkg
      self.aspellDicts.en # not emacs pkg
      #magit
      #projectile
      #switch-window
      #smart-mode-line
      #undo-tree
      #use-package
    ]);

    unison_2_40 = self.stdenv.lib.overrideDerivation self.unison (old: rec {
      name = "unison-2.40.102";
      src = self.fetchurl {
        url = "http://www.seas.upenn.edu/~bcpierce/unison/download/releases/stable/${name}.tar.gz";
        sha256 = "0m78q5vnsric1virvkmxxx32ipaq0cnj0kbirdbg36395gq94jix";
      };
    });

    haskellPackages = super.haskellPackages.override {
      overrides = self: super: {
      }
      #// (clashProjects self super)
      ;
    };
  }
  #// (cncProjects self super)
  ;
}
