{ stdenv, fetchFromGitHub, gcc7, libtool, automake, autoconf }:

stdenv.mkDerivation rec {
  name = "cilk-plus-rts-with-stats";

  src = fetchFromGitHub {
    owner  = "deepsea-inria";
    repo   = "cilk-plus-rts-with-stats";
    rev    = "d143c31554bc9c122d168ec22ed65e7941d4c91d";
    sha256 = "123bsrqcp6kq6xz2rn4bvj2nifflfci7rd9ij82fpi2x6xvvsmsb";
  };

  buildInputs = [ libtool automake autoconf gcc7 ];

  preConfigure = "libtoolize && aclocal && automake --add-missing && autoconf";

  enableParallelBuilding = true;

  meta = {
    description = "A version of the Cilk Plus runtime system for GCC that can collect and output stats collected by the work-stealing scheduler.";
    license = "MIT";
    homepage = http://deepsea.inria.fr/;
  };
}

  
