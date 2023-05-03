{ stdenv, fetchgit, cmake, parlaylibSrc, taskparts }:

stdenv.mkDerivation rec {

  name = "parlaylib-examples";

  src = parlaylibSrc;
  
  buildInputs = [ cmake taskparts ];

  # for debugging:  -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
  configurePhase = ''
    mkdir -p build
    cmake . -DCMAKE_INSTALL_PREFIX:PATH=$out -DCMAKE_BUILD_TYPE=Release -DPARLAY_EXAMPLES=On -DPARLAY_TASKPARTS=On -DTASKPARTS_SEARCH_DIR=${taskparts}
  '';

  buildPhase = ''
    cmake --build . --target install -j
    cp -R examples $out/
  '';
  
}
