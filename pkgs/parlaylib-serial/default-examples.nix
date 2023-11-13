{ stdenv, fetchgit, cmake, parlaylibSrc, few ? false }:

stdenv.mkDerivation rec {

  name = "parlaylib-serial-examples";

  src = parlaylibSrc;
  
  buildInputs = [ cmake ];

  configurePhase =
    let
      examples-cfg = if few then "-DFEW_EXAMPLES=ON" else "";
    in
    ''
    mkdir -p build
    cmake . -DCMAKE_INSTALL_PREFIX:PATH=$out -DCMAKE_BUILD_TYPE=Release -DPARLAY_SEQUENTIAL=On -DPARLAY_EXAMPLES=On ${examples-cfg}
  '';

  buildPhase = ''
    cmake --build . --target install -j $NIX_BUILD_CORES
    cp -R examples $out/
  '';
  
}
