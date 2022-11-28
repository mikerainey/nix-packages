{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  packages = rec {

#    parlaylib = callPackage ./pkgs/parlaylib {};
    parlaylib-benchmark = callPackage ./pkgs/parlaylib/default-benchmark.nix { gbenchmark-src = fetchFromGitHub {
      owner = "google";
      repo = "benchmark";
      rev = "v1.6.2";
      sha256 = "0rj5ybcf37gjw848xpm02xq2mnkzrjj9lalq9mk6059l5z38aj69";
    }; };
    
    cmdline = callPackage ./pkgs/cmdline {};

    cilk-plus-rts-with-stats = callPackage ./pkgs/cilk-plus-rts-with-stats { stdenv = pkgs.stdenvNoCC; gcc7 = pkgs.gcc7; };

    inherit pkgs;
  };
in
  packages
