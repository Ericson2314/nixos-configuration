{ stdenv, lib, buildEnv, makeWrapper, runCommand, fetchurl, zlib, rsync }:

# rustc and cargo nightly binaries

let
  convertPlatform = system:
    if      system == "i686-linux"    then "i686-unknown-linux-gnu"
    else if system == "x86_64-linux"  then "x86_64-unknown-linux-gnu"
    else if system == "i686-darwin"   then "i686-apple-darwin"
    else if system == "x86_64-darwin" then "x86_64-apple-darwin"
    else abort "no snapshot to bootstrap for this platform (missing target triple)";

  thisSys = convertPlatform stdenv.system;

  mkUrl = { pname, archive, date, system }:
    "${archive}/${date}/${pname}-nightly-${system}.tar.gz";

  fetch = args: let
      url = mkUrl { inherit (args) pname archive date system; };
      download = builtins.fetchurl (url + ".sha256");
      contents = builtins.readFile download;
      sha256 = args.hash or lib.head (lib.strings.splitString " " contents);
    in fetchurl { inherit url sha256; };

  generic = { pname, archive, exes }:
      { date, system ? thisSys, ... } @ args:
      stdenv.mkDerivation rec {
    name = "${pname}-${version}";
    version = "nightly-${date}";
    # TODO meta;
    outputs = [ "out" "doc" ];
    src = fetch (args // { inherit pname archive system; });
    nativeBuildInputs = [ rsync ];
    dontStrip = true;
    installPhase = ''
      rsync --chmod=u+w -r ./*/ $out/
    '';
    preFixup = if stdenv.isLinux then let
      # it's overkill, but fixup will prune
      rpath = "$out/lib:" + lib.makeLibraryPath [ zlib stdenv.cc.cc.lib ];
    in ''
      for executable in ${lib.concatStringsSep " " exes}; do
        patchelf \
          --interpreter "$(< $NIX_CC/nix-support/dynamic-linker)" \
          --set-rpath "${rpath}" \
          "$out/bin/$executable"
      done
      for library in $out/lib/*.so; do
        patchelf --set-rpath "${rpath}" "$library"
      done
    '' else "";
  };

in rec {
  rustc = generic {
    pname = "rustc";
    archive = "https://static.rust-lang.org/dist";
    exes = [ "rustc" "rustdoc" ];
  };

  rustcWithSysroots = { rustc, sysroots ? [] }: buildEnv {
    name = "combined-sysroots";
    paths = [ rustc ] ++ sysroots;
    pathsToLink = [ "/lib" "/share" ];
    #buildInputs = [ makeWrapper ];
    # Can't use wrapper script because of https://github.com/rust-lang/rust/issues/31943
    postBuild = ''
      mkdir -p $out/bin/
      cp ${rustc}/bin/* $out/bin/
    '';
  };

  rust-std = { date, system ? thisSys, ... } @ args:
      stdenv.mkDerivation rec {
    # Strip install.sh, etc
    pname = "rust-std";
    version = "nightly-${date}";
    name = "${pname}-${version}-${system}";
    src = fetch (args // {
      inherit pname system;
      archive = "https://static.rust-lang.org/dist";
    });
    installPhase = ''
      mkdir -p $out
      mv ./*/* $out/
      rm $out/manifest.in
    '';
  };

  cargo = generic {
    pname = "cargo";
    archive = "https://static.rust-lang.org/cargo-dist";
    exes = [ "cargo" ];
  };

  rust = generic {
    pname = "rust";
    archive = "https://static.rust-lang.org/dist";
    exes = [ "rustc" "rustdoc" "cargo" ];
  };
}
