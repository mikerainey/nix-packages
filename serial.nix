{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  packages = rec {

    #####################################################################
    # parlaylibSrc = fetchgit {                                         #
    #   url = "https://github.com/mikerainey/parlaylib.git";            #
    #   rev = "ad9fa568e2cadbdc01bdb392ccc7cdc95581c73f";               #
    #   sha256 = "sha256-R7GeBk8xBPgnbO0U21bRGc67yz22HpN9djSQYaX6Sak="; #
    # };                                                                #
    #####################################################################
    parlaylibSrc=./../parlaylib;
    
    parlaylib-examples = callPackage ./pkgs/parlaylib-serial/default-examples.nix { parlaylibSrc=parlaylibSrc; };
    
    inherit pkgs;
  };
in
  packages
