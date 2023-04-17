{ pkgs   ? import <nixpkgs> {},
  stdenv ? pkgs.stdenv,
  fetchurl ? pkgs.fetchurl
}:

# IMPORTANT: can only run on Ubuntu v22.04 (using the nix package manager)

stdenv.mkDerivation rec {
  name = "opencilk-v2-for-ubuntu-v22";

  src = fetchurl {
    url = "https://github.com/OpenCilk/opencilk-project/releases/download/opencilk/v2.0/OpenCilk-2.0.0-x86_64-Linux-Ubuntu-22.04.tar.gz";
    sha256 = "11kfar0arjswwipm9z7w4a07bnsxh8j2g8w5d2l4xqfmd945hkz5";
  };
  
  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';

  meta = {
    description = "Wrapper for OpenCilk for use on Ubuntu 22 (only).";
    license = "MIT";
  };
}
