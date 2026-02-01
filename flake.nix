{
  description = "Nix packages for parallel computing libraries and tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # Source inputs for packages that need external sources
    flexibench-src = {
      url = "git+ssh://git@github.com/mikerainey/flexibench";
      flake = false;
    };
    taskparts-src = {
      url = "git+https://github.com/mikerainey/taskparts?ref=successor";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, flexibench-src, taskparts-src }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Use LLVM 18 stdenv for better C++ compatibility
        llvmStdenv = pkgs.llvmPackages_18.stdenv;

        taskparts = pkgs.callPackage ./pkgs/taskparts {
          taskpartsSrc = taskparts-src;
        };

        # Taskparts built with LLVM 18 and stats enabled
        taskpartsLlvm = pkgs.callPackage ./pkgs/taskparts {
          stdenv = llvmStdenv;
          taskpartsSrc = taskparts-src;
          statsEnable = true;
        };
      in {
        packages = {
          cmdline = pkgs.callPackage ./pkgs/cmdline {};

          flexibench = pkgs.python3Packages.callPackage ./pkgs/flexibench {
            flexibenchSrc = flexibench-src;
          };

          mpl = import ./pkgs/mpl { inherit pkgs; };

          parlaylib = pkgs.callPackage ./pkgs/parlaylib {};

          parlaylib-taskparts = pkgs.callPackage ./pkgs/parlaylib {
            inherit taskparts;
          };

          parlaylib-taskparts-examples = pkgs.callPackage ./pkgs/parlaylib {
            stdenv = llvmStdenv;
            taskparts = taskpartsLlvm;
            parlayExamples = true;
            parlayInstallExamples = true;
            parlayFewExamples = true;
          };

          smlfmt = import ./pkgs/smlfmt { inherit pkgs; };

          inherit taskparts;
        };

        # Expose all packages as the default
        packages.default = pkgs.symlinkJoin {
          name = "nix-packages-all";
          paths = builtins.attrValues (builtins.removeAttrs self.packages.${system} ["default"]);
        };
      }
    );
}
