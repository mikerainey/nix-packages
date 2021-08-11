{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  packages = rec {
    
    parlaylib = callPackage ./pkgs/parlaylib {};

    mcsl = callPackage ./pkgs/mcsl {};
    cmdline = callPackage ./pkgs/cmdline {};
    cilk-plus-rts-with-stats = callPackage ./pkgs/cilk-plus-rts-with-stats { stdenv = pkgs.stdenvNoCC; gcc7 = pkgs.gcc7; };

    emacs = callPackage ./pkgs/emacs {};

    inherit pkgs;
  };
in
  packages
