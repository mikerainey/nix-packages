{ stdenv, fetchgit }:

stdenv.mkDerivation rec {
  
  name = "mcsl";

  src = fetchgit {
    url = "https://github.com/mikerainey/mcsl.git";
    rev = "32a64e3764bcf20076b7bbb3cacc6caa3884a12a";
    sha256 = "016q1jdc05559sc2sbx72a3zi37v6iw6sqa2wv7n6fvxscdf748r";
  };

  installPhase = ''
    mkdir -p $out/include/
    cp include/*.hpp $out/include/
  '';

  meta = {
    description = "A C++ header library containing various useful algorithms for green threads.";
    license = "MIT";
    homepage = http://mike-rainey.site/;
  };
  
}
