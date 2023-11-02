{ stdenv, fetchgit, cmake, parlaylibSrc, taskparts }:

stdenv.mkDerivation rec {

  name = "parlaylib-taskparts-examples";

  src = parlaylibSrc;
  
  buildInputs = [ cmake taskparts ];

  # for debugging:  -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
  #                 -DFEW_EXAMPLES=ON
  configurePhase =
    let
      taskparts-cfg =
        (if taskparts.header-only then
          "-DPARLAY_TASKPARTSHDRONLY=On -DTASKPARTS_STATS=On" +
          (if taskparts.elastic-scheduling then "" else " -DTASKPARTS_NONELASTIC=On")
         else
           "-DPARLAY_TASKPARTS=On") + "-DTASKPARTS_SEARCH_DIR=${taskparts}";
    in
      ''
      mkdir -p build
      cmake . -DCMAKE_INSTALL_PREFIX:PATH=$out -DCMAKE_BUILD_TYPE=Release -DPARLAY_EXAMPLES=On ${taskparts-cfg}
      '';

  buildPhase = ''
    cmake --build . --target install -j $NIX_BUILD_CORES
    cp -R examples $out/
  '';
  
}
