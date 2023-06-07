{ stdenv, fetchgit, cmake, parlaylibSrc }:

stdenv.mkDerivation rec {

  name = "parlaylib-examples";

  src = parlaylibSrc;
  
  buildInputs = [ cmake ];

  configurePhase = ''
    mkdir -p build
    cmake . -DCMAKE_INSTALL_PREFIX:PATH=$out -DCMAKE_BUILD_TYPE=Release -DPARLAY_EXAMPLES=On
  '';

  buildPhase = ''
    cmake --build . --target install -j $NIX_BUILD_CORES
    cp -R examples $out/
  '';
  
}
