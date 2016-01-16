{ stdenv, lib, fetchzip, zlib }:

# rustc and cargo nightly binaries

let
  target = if stdenv.system == "i686-linux"
    then "i686-unknown-linux-gnu"
    else if stdenv.system == "x86_64-linux"
    then "x86_64-unknown-linux-gnu"
    else if stdenv.system == "i686-darwin"
    then "i686-apple-darwin"
    else if stdenv.system == "x86_64-darwin"
    then "x86_64-apple-darwin"
    else abort "no snapshot to bootstrap for this platform (missing target triple)";

  generic = { pname, archive, exes}: { date, hash }: stdenv.mkDerivation rec {
    name = "${pname}-${version}";
    version = "nightly-${date}";
    # TODO meta;

    src = fetchzip {
      url = "${archive}/${date}/${pname}-nightly-${target}.tar.gz";
      sha256 = hash;
    };

    dontStrip = true;

    installPhase = ''
      mv ${pname} $out
    '';

    preFixup = if stdenv.isLinux then let
      # it's overkill, but fixup will prune
      rpath = stdenv.lib.concatStringsSep ":" [
        "$out/lib"
        (stdenv.lib.makeLibraryPath [ zlib ])
        ''${stdenv.cc.cc}/lib${stdenv.lib.optionalString stdenv.is64bit "64"}''
      ];
    in ''
      for executable in ${stdenv.lib.concatMapStringsSep " " (s: "$out/bin/" + s) exes}; do
        patchelf --interpreter "${stdenv.glibc}/lib/${stdenv.cc.dynamicLinker}" \
          --set-rpath "${rpath}" \
          "$executable"
      done
      for library in $out/lib/*.so $cargo/lib/*.so; do
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

  cargo = generic {
    pname = "cargo";
    archive = "https://static.rust-lang.org/cargo-dist";
    exes = [ "cargo" ];
  };
}
