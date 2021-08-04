{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  packages = rec {
    
    parlaylib = callPackage ./pkgs/parlaylib {};

    mcsl = callPackage ./pkgs/mcsl {};
    cmdline = callPackage ./pkgs/cmdline {};

    emacs = callPackage ./pkgs/emacs {};

    inherit pkgs;
  };
in
  packages
