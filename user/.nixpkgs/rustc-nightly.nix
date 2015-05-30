{ stdenv, lib, fetchzip, zlib, rustcMaster
, date, hash
}:

/* rustc nightly binary */

let target = if stdenv.system == "i686-linux"
      then "i686-unknown-linux-gnu"
      else if stdenv.system == "x86_64-linux"
      then "x86_64-unknown-linux-gnu"
      else if stdenv.system == "i686-darwin"
      then "i686-apple-darwin"
      else if stdenv.system == "x86_64-darwin"
      then "x86_64-apple-darwin"
      else abort "no snapshot to bootstrap for this platform (missing target triple)";
in

stdenv.mkDerivation rec {
  name = "rust-${version}";
  version = "nightly-${date}";
  inherit (rustcMaster) meta;

  src = fetchzip {
    url = "https://static.rust-lang.org/dist/${date}/rust-nightly-${target}.tar.gz";
    sha256 = hash;
  };

  dontStrip = true;

  outputs = ["rustc" "cargo"];

  installPhase = ''
    mkdir -p $rustc/bin
    mkdir -p $rustc/lib
    mkdir -p $rustc/share

    mkdir -p $cargo/bin
    mkdir -p $cargo/lib
    mkdir -p $cargo/share
    mkdir -p $cargo/etc

    mv -t $rustc/bin   -- rustc/bin/*
    mv -t $rustc/lib   -- rustc/lib/*
    mv -t $rustc/share -- rustc/share/*

    mv -t $cargo/bin   -- cargo/bin/*
    mv -t $cargo/lib   -- cargo/lib/*
    mv -t $cargo/share -- cargo/share/*
    mv -t $cargo/etc   -- cargo/etc/*
  '';

  preFixup = if stdenv.isLinux then let
    # it's overkill, but fixup will prune
    rpath = stdenv.lib.concatStringsSep ":" [
      "$cargo/lib"
      "$rustc/lib"
      (stdenv.lib.makeLibraryPath [ zlib ])
      ''${stdenv.cc.cc}/lib${stdenv.lib.optionalString stdenv.is64bit "64"}''
    ];
    exes = stdenv.lib.concatStringsSep " " [
      "$rustc/bin/rustc"
      "$rustc/bin/rustdoc"
      "$cargo/bin/cargo"
    ];
  in ''
    for executable in ${exes}; do
      patchelf --interpreter "${stdenv.glibc}/lib/${stdenv.cc.dynamicLinker}" \
               --set-rpath "${rpath}" \
               "$executable"
    done
    for library in $rustc/lib/*.so $cargo/lib/*.so; do
      patchelf --set-rpath "${rpath}" "$library"
    done
  '' else "";
}
