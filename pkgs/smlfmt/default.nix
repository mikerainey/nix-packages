{ pkgs   ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  dfltSrc ? pkgs.fetchFromGitHub {
    owner  = "shwestrick";
    repo   = "smlfmt";
    rev    = "6158c551766865d7184624656a938edb73bd588c";
    sha256 = "sha256-JCCbidVVtuGE1i4VQSIOnUlzJ4ROUNlPwvI7QqHav9Y=";
  },
  mlton ? pkgs.mlton
}:

stdenv.mkDerivation rec {
  name = "smlfmt";

  src = dfltSrc;

  buildInputs = [ mlton ];

  installPhase = ''
    make install PREFIX=$out
  '';

  meta = {
    description = "A code formatter for Standard ML.";
    license = "MIT";
    homepage = https://github.com/shwestrick/smlfmt;
  };
}
