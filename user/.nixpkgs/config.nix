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
  packageOverrides = super: let self = super.pkgs; in {
    myTexLive = with self; texLiveAggregationFun {
      paths = [ texLive texLiveExtra /*texLiveBeamer*/ ];
    };

    myEmacs = self.emacsWithPackages (with self.emacsPackagesNg; [
      agda2-mode

      caml
      tuareg

      haskell-mode
      structured-haskell-mode

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

    rustcNightly = self.callPackage ./rustc-nightly.nix {
      date = "2015-05-28";
      hash = "0ayslz08v69xaiq0qdgjxz23spcw58fgaaadk1njqif2im1cn7ri";
    };

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
