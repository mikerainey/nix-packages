{ stdenv, taskpartsSrc, cmake, hwloc, enable-elastic-scheduling ? (hwloc != null) }:

stdenv.mkDerivation rec {
  name = "taskparts";

  src = taskpartsSrc;

  buildInputs = [ cmake ] ++ (if hwloc == null then [] else [ hwloc ]);

  # for debugging:  -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
  configurePhase =
    let
      hwloc-cfg = if hwloc == null then "" else "-DHWLOC_DEV_PATH=${hwloc.dev} -DHWLOC_LIB_PATH=${hwloc.lib}";
      elastic-cfg = if enable-elastic-scheduling then "" else "-DNONELASTIC=ON";
      cfg = "${hwloc-cfg} ${elastic-cfg}";
    in
      ''
      mkdir -p build
      cmake . -DCMAKE_INSTALL_PREFIX:PATH=$out -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DCMAKE_BUILD_TYPE=Release -DSTATS=ON ${cfg}
      '';

  meta = {
    description = "A Task-Parallel Run-Time System for C++";
    license = "MIT";
    homepage = https://github.com/mikerainey/taskparts;
  };

}
