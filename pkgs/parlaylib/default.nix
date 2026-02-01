{ stdenv, lib, fetchgit, cmake,
  parlaySrc ? fetchgit {
    url = "https://github.com/mikerainey/parlaylib.git";
    rev = "80bf19db490f5985d364277f41a3d558e404b0bd";
    sha256 = "sha256-/EQteYWf5P0sq9IRbS79ukWmmY99q1NH8L1mgBUzKRY=";
  },
  parlaySequential ? false, taskparts ? null, parlayCilkPlus ? false, parlayOpenCilk ? false, parlayOpenMP ? false,
  parlayExamples ? false, parlayInstallExamples ? false, parlayExampleData ? false, parlayFewExamples ? false,
  parlayDisableElasticParallelism ? false,
  gbenchmarkSrc ? null,
  gtestSrc ? null
}:

let
  # Platform detection flags for taskparts (header-only library needs these at compile time)
  platformFlag = if stdenv.isDarwin then "-DTASKPARTS_DARWIN=1" else "-DTASKPARTS_POSIX=1";
  archFlag = if stdenv.isAarch64 then "-DTASKPARTS_ARM64=1" else "-DTASKPARTS_X64=1";
in

stdenv.mkDerivation rec {

  name = "parlaylib";

  src = parlaySrc;

  nativeBuildInputs = [ cmake ]
                      ++ (if taskparts != null then [ taskparts ] else []);

  # Set CXXFLAGS environment variable for taskparts platform flags
  CXXFLAGS = lib.optionalString (taskparts != null) "${platformFlag} ${archFlag}";

  cmakeFlags = [
    (lib.strings.optionalString parlayExamples "-DPARLAY_EXAMPLES=ON")
    (lib.strings.optionalString parlayInstallExamples "-DPARLAY_INSTALL_EXAMPLES=ON")
    (lib.strings.optionalString parlayExampleData "-DPARLAY_EXAMPLE_DATA=ON")
    (lib.strings.optionalString parlayFewExamples "-DFEW_EXAMPLES=ON")
    (lib.strings.optionalString parlayDisableElasticParallelism "-DPARLAY_ELASTIC_PARALLELISM=OFF")
    (lib.strings.optionalString parlaySequential "-DPARLAY_SEQUENTIAL=ON")
    (lib.strings.optionalString (taskparts != null) "-DPARLAY_TASKPARTS=ON")
    (lib.strings.optionalString parlayCilkPlus "-DPARLAY_CILKPLUS=ON")
    (lib.strings.optionalString parlayOpenCilk "-DPARLAY_OPENCILK=ON")
    (lib.strings.optionalString parlayOpenMP "-DPARLAY_OPENMP=ON")
    (lib.strings.optionalString (gbenchmarkSrc != null) "-DFETCHCONTENT_SOURCE_DIR_BENCHMARK=${gbenchmarkSrc}")
    (lib.strings.optionalString (gtestSrc != null) "-DCMAKE_BUILD_TYPE=Debug")
    (lib.strings.optionalString (gtestSrc != null) "-DFETCHCONTENT_SOURCE_DIR_GOOGLETEST=${gtestSrc}")
  ];

  meta = {
    description = "A Toolkit for Programming Parallel Algorithms on Shared-Memory Multicore Machines";
    license = "MIT";
    homepage = https://cmuparlay.github.io/parlaylib/;
  };

}

# LATER: to enable build with TBB, we need to define a TBB nix build script

  # nix-build default.nix --arg stdenv '(import <nixpkgs> {}).stdenv' --arg cmake '(import <nixpkgs> {}).cmake' --arg fetchgit '(import <nixpkgs> {}).fetchgit' --arg lib '(import <nixpkgs> {}).lib' --arg parlayExamples true --arg parlayInstallExamples true --arg parlayFewExamples true  --arg taskparts 'import ../taskparts/default.nix { stdenv=(import <nixpkgs> {}).stdenv; lib=(import <nixpkgs> {}).lib; taskpartsSrc=../../../successor; cmake=(import <nixpkgs> {}).cmake; statsEnable=true;}'
