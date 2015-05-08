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

  cncProjects = super: let
      cncRoot  = projectsRoot + "cnc/";
    in {
      petool   = super.callPackage (cncRoot + "petool") {};
      engine1  = super.callPackage (cncRoot + "engine1") {};
      engine2  = super.callPackage (cncRoot + "engine2") {};
      dune2k   = super.callPackage (cncRoot + "dune2k") {};
  };
in
{
  packageOverrides = super: let self = super.pkgs; in {
    myTexLive = with super; texLiveAggregationFun {
      paths = [ texLive texLiveExtra texLiveBeamer ];
    };

    #rustcNightly = super.callPackage (projects + "/nixpkgs/pkgs/development/compilers/rustc/nightly.nix") {};

    haskellngPackages = super.haskellngPackages.override {
      overrides = self: super: {
      }
      #// (clashProjects self super)
      ;
    };
  }
  #// (cncProjects super)
  ;
}
