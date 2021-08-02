{ stdenv, fetchgit, cmake }:

stdenv.mkDerivation rec {

  name = "parlaylib";

  src = fetchgit {
    url = "https://github.com/cmuparlay/parlaylib.git";
    rev = "caaf22e301362402623eaa2c6bd920caca7c86d1";
    sha256 = "1c3nn3wa5m72xw27xmh6kkkfvi6mfwl6k5qys3ab4l5k5hk2y093";
  };

  buildInputs = [ cmake ];

  configurePhase = ''
    cmake . -DCMAKE_INSTALL_PREFIX:PATH=$out
  '';

  buildPhase = ''
    cmake --build . --target install
  '';
  
}
