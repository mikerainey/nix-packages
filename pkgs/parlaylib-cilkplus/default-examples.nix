{ stdenv, fetchgit, cmake, parlaylibSrc }:

stdenv.mkDerivation rec {

  name = "parlaylib-cilkplus-examples";

  src = parlaylibSrc;
  
  buildInputs = [ cmake ];

  # for debugging:  -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
  configurePhase = ''
    mkdir -p build
    cmake . -DCMAKE_INSTALL_PREFIX:PATH=$out -DCMAKE_BUILD_TYPE=Release -DPARLAY_EXAMPLES=On -DPARLAY_CILKPLUS=On
  '';

  buildPhase = ''
    cmake --build . --target install -j
    cp -R examples $out/
  '';
  
}
