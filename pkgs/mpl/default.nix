{ pkgs   ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  dfltSrc ? pkgs.fetchFromGitHub {
    owner  = "MPLLang";
    repo   = "mpl";
    rev    = "0a1b9a9a87a3293365661de448edf475e3847ae9";
    sha256 = "sha256-KYDL33QZp/lrOQeDpF+E6IH7drkmGpJL6krym001ZM8=";
  },
  gcc ? pkgs.gcc,
  gmp ? pkgs.gmp,
  gnumake ? pkgs.gnumake,
  binutils ? pkgs.binutils-unwrapped,
  bash ? pkgs.bash,
  mlton ? pkgs.mlton
}:

stdenv.mkDerivation rec {
  name = "mpl";

  src = dfltSrc;

  buildInputs = [ gcc gmp gnumake binutils bash mlton ];

  enableParallelBuilding = true;
  
  buildPhase = ''
    find . -type f | grep -v -e '\.tgz''$' | xargs sed -i "s@/usr/bin/env bash@$(type -p bash)@"
    make dirs
    make runtime -j $NIX_BUILD_CORES
    make
  '';

  installPhase = ''
    make install PREFIX=$out
  '';

  meta = {
    description = "The MaPLe compiler for Parallel ML.";
    license = "HPND";
    homepage = https://github.com/MPLLang/mpl;
  };
}
