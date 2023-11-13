{ stdenv, fetchgit, cmake, parlaylibSrc, taskparts, few ? false }:

stdenv.mkDerivation rec {

  name = "parlaylib-taskparts-examples";

  src = parlaylibSrc;
  
  buildInputs = [ cmake taskparts ];

  # for debugging:  -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
  configurePhase =
    let
      taskparts-cfg =
        (if taskparts.header-only then
          "-DPARLAY_TASKPARTSHDRONLY=On -DTASKPARTS_STATS=On" +
          (if ! taskparts.elastic-scheduling-disabled then "" else " -DTASKPARTS_NONELASTIC=On")
         else
           "-DPARLAY_TASKPARTS=On") + "-DTASKPARTS_SEARCH_DIR=${taskparts}";
      deque-cfg = if taskparts.ywra-deque-enabled then "-DTASKPARTS_YWRA_DEQUE=ON" else "";
      examples-cfg = if few then "-DFEW_EXAMPLES=ON" else "";
    in
      ''
      mkdir -p build
      cmake . -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON -DCMAKE_INSTALL_PREFIX:PATH=$out -DCMAKE_BUILD_TYPE=Release -DPARLAY_EXAMPLES=On ${taskparts-cfg} ${examples-cfg} ${deque-cfg}
      '';

  buildPhase = ''
    cmake --build . --target install -j $NIX_BUILD_CORES
    cp -R examples $out/
  '';
  
}
