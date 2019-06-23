let
  projectsRoot = "/home/jcericson/Code/git/";

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
