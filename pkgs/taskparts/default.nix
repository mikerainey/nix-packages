{ stdenv, lib, taskpartsSrc, cmake,
  sharedLinkedLibraryEnable ? false,
  statsEnable ? false, loggingEnable ? false,
  chaseLevDequeEnable ? false,
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
  ];

  meta = {
    description = "A Toolkit for Programming Parallel Algorithms on Shared-Memory Multicore Machines";
    license = "MIT";
    homepage = https://cmuparlay.github.io/parlaylib/;
  };

}
