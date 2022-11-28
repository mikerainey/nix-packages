{ stdenv, fetchgit, cmake }:

stdenv.mkDerivation rec {

  name = "parlaylib-examples";

  src = fetchgit {
    url = "https://github.com/cmuparlay/parlaylib.git";
    rev = "6302233a72199b9a0f69e4bdb63928ebf5e8f3cc";
    sha256 = "0gh8gidb8f8da3cc10wxbc9vrlgl5bq0sa3s5hllmd77dfjkp4mh";
  };

  buildInputs = [ cmake ];

  configurePhase = ''
    mkdir -p build
    cmake . -DCMAKE_INSTALL_PREFIX:PATH=$out -DCMAKE_BUILD_TYPE=Release -DPARLAY_EXAMPLES=On
  '';

  buildPhase = ''
    cmake --build . --target install
    cp -R examples $out/
  '';
  
}
