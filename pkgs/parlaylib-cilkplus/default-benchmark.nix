{ stdenv, fetchgit, cmake, gbenchmark-src }:

stdenv.mkDerivation rec {

  name = "parlaylib-benchmark";

  src = fetchgit {
    url = "https://github.com/cmuparlay/parlaylib.git";
    rev = "7cdb4cae8f020525f5eb4ad82e2565d1e38cfbc3";
    sha256 = "sha256-ZOmqME4T5Uc9OMDswCj5z6c+I1KG3fBiWIYDMFyeJ74=";
  };

  buildInputs = [ cmake ];

  configurePhase = ''
    mkdir -p build
    cmake . -DCMAKE_INSTALL_PREFIX:PATH=$out -DCMAKE_BUILD_TYPE=Release -DPARLAY_BENCHMARK=On -DFETCHCONTENT_SOURCE_DIR_BENCHMARK=${gbenchmark-src}
  '';

  buildPhase = ''
    cmake --build . --target install
    cp -R benchmark $out/
  '';
  
}
