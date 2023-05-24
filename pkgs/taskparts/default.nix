{ stdenv, taskpartsSrc, cmake }:

stdenv.mkDerivation rec {
  name = "taskparts";

  src = taskpartsSrc;

  buildInputs = [ cmake ];

  meta = {
    description = "A Task-Parallel Run-Time System for C++";
    license = "MIT";
    homepage = https://github.com/mikerainey/taskparts;
  };

}
