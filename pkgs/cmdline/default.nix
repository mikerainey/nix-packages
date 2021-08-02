{ stdenv, fetchgit, pandoc, texlive, buildDocs ? false }:

# To build docs in html/pdf format, use:
#   buildDocs = true; texlive = texlive.combined.scheme-medium;

stdenv.mkDerivation rec {
  
  name = "cmdline";

  src = fetchgit {
    url = "https://github.com/deepsea-inria/cmdline.git";
    rev = "5d9cdddcd5e6e14ae5b9b8d1f7d58c26f750a6d4";
    sha256 = "1m2iqxvsa41xis19nd3b8ifwz9ajjmkan9jipblkin33hyw2dxw2";
  };

  buildInputs = if buildDocs then [ pandoc texlive ] else [];

  buildPhase = if buildDocs then ''
    make README.pdf README.html
  ''
  else ''
    # nothing to build
  '';
  
  installPhase = ''
    mkdir -p $out/include/
    cp include/cmdline.hpp $out/include/
    mkdir -p $out/doc
    cp README.* Makefile cmdline.css $out/doc/
  '';

  meta = {
    description = "A small, self-contained header file that implements the Deepsea command-line conventions.";
    license = "MIT";
    homepage = http://deepsea.inria.fr/;
  };
  
}
