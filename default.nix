{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  packages = rec {

    # parlaylib = callPackage ./pkgs/parlaylib {};
    # parlaylib-examples = callPackage ./pkgs/parlaylib/default-examples.nix {};
    # parlaylib-benchmark = callPackage ./pkgs/parlaylib/default-benchmark.nix {
    #   gbenchmark-src = fetchFromGitHub {
    #     owner = "google";
    #     repo = "benchmark";
    #     rev = "v1.6.2";
    #     sha256 = "0rj5ybcf37gjw848xpm02xq2mnkzrjj9lalq9mk6059l5z38aj69";
    #   };
    # };
    # parlaylib-test = callPackage ./pkgs/parlaylib/default-test.nix {
    #   gtest-src = fetchFromGitHub {
    #     owner = "google";
    #     repo = "googletest";
    #     rev = "v1.12.1";
    #     sha256 = "1cv55x3amwrvfan9pr8dfnicwr8r6ar3yf6cg9v6nykd6m2v3qsv";
    #   };
    # };
    
    cmdline = callPackage ./pkgs/cmdline {};

    cilk-plus-rts-with-stats = callPackage ./pkgs/cilk-plus-rts-with-stats {
      stdenv = pkgs.stdenvNoCC;
      gcc7 = pkgs.gcc7;
    };

    smlfmt = callPackage ./pkgs/smlfmt {};

    taskparts-hdronly = callPackage ./pkgs/taskparts/hdronly.nix {taskpartsSrc = ./../successor;};

    inherit pkgs;
  };
in
  packages
