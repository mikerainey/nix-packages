{ stdenv, taskpartsSrc, cmake }:

stdenv.mkDerivation rec {
  name = "taskparts-hdronly";

  src = taskpartsSrc;

  buildInputs = [ cmake ];

  configurePhase =
    ''
     mkdir -p build
     cmake . -DCMAKE_INSTALL_PREFIX:PATH=$out -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DCMAKE_BUILD_TYPE=Release -DTASKPARTS_HEADER_ONLY=On
    '';

  meta = {
    description = "A Task-Parallel Run-Time System for C++ (header-file-only version)";
    license = "MIT";
    homepage = https://github.com/mikerainey/taskparts;
  };

}
