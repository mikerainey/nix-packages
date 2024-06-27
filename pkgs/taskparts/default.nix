{ stdenv, lib, taskpartsSrc, cmake,
  sharedLinkedLibraryEnable ? false,
  statsEnable ? false, loggingEnable ? false,
  chaseLevDequeEnable ? false,
  disableElasticParallelism ? false,
  hwloc ? null
}:

stdenv.mkDerivation rec {
  name = "taskparts";

  src = taskpartsSrc;

  nativeBuildInputs = [ cmake ] ++ (if hwloc != null then [ hwloc ] else [ ]);
 
  cmakeFlags = [
    (lib.strings.optionalString sharedLinkedLibraryEnable "-DSHARED_LINKED_LIBRARY=ON")
    (lib.strings.optionalString statsEnable "-DSTATS=ON")
    (lib.strings.optionalString loggingEnable "-DLOGGING=ON")
    (lib.strings.optionalString (hwloc != null) "-DHWLOC=ON")
    (lib.strings.optionalString disableElasticParallelism "-DNONELASTIC=ON")
  ];


  meta = {
    description = " A C++ library to support task parallelism on multicore platforms";
    license = "MIT";
    homepage = https://github.com/mikerainey/taskparts;
  };

}
