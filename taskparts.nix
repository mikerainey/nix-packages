{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  packages = rec {

    taskpartsSrc = fetchgit {
      url = "https://github.com/mikerainey/taskparts.git";
      rev = "b52dec0f42e15da4158e84884930e63c73a2a02f";
      sha256 = "sha256-ryxBVNb1kBlHIc/um+OiUz8tNHnQHFHjBSUielBvnkg=";
    };
    taskparts = callPackage ./pkgs/taskparts/default.nix { taskpartsSrc=taskpartsSrc; };

    #####################################################################
    # parlaylibSrc = fetchgit {                                         #
    #   url = "https://github.com/mikerainey/parlaylib.git";            #
    #   rev = "ad9fa568e2cadbdc01bdb392ccc7cdc95581c73f";               #
    #   sha256 = "sha256-R7GeBk8xBPgnbO0U21bRGc67yz22HpN9djSQYaX6Sak="; #
    # };                                                                #
    #####################################################################
    parlaylibSrc=./../parlaylib;
    
    parlaylib-taskparts-examples = callPackage ./pkgs/parlaylib-taskparts/default-examples.nix { taskparts=taskparts; parlaylibSrc=parlaylibSrc; };
#    parlaylib-cilkplus-examples = callPackage ./pkgs/parlaylib-cilkplus/default-examples.nix { stdenv=pkgs.gcc7Stdenv; parlaylibSrc=parlaylibSrc; };
#    parlaylib-examples = callPackage ./pkgs/parlaylib/default-examples.nix { parlaylibSrc=parlaylibSrc; };
    
    inherit pkgs;
  };
in
  packages
