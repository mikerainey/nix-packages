{ stdenv, lib, fetchgit, cmake, parlay,
  pamSrc ? fetchgit {
    url = "https://github.com/mikerainey/PAM.git";
    rev = "ca258637803e35460a694d944037865a58cec787";
    sha256 = "sha256-VEMS9+vQzpeMe/0EX9M8w5nY4xdeGGwOLKGacdTa6pE=";
  }
}:

stdenv.mkDerivation rec {

  name = "PAM";

  src = pamSrc;

  nativeBuildInputs = [ cmake parlay ];

  cmakeFlags = [
  ];

  meta = {
    description = "Parallel Augmented Maps";
    license = "MIT";
    homepage = https://github.com/cmuparlay/PAM
  };

}
