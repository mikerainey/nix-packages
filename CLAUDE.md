# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Nix flake repository containing derivations for parallel computing libraries and tools, primarily focused on the Deepsea/CMU Parlay ecosystem.

## Build Commands

Build packages using the flake:
```bash
nix build .#<package-name>
```

### Available Packages

| Package | Description | Command |
|---------|-------------|---------|
| `cmdline` | Command-line parsing header library | `nix build .#cmdline` |
| `flexibench` | CLI tool for benchmarking software (Python) | `nix build .#flexibench` |
| `mpl` | MaPLe compiler for Parallel ML | `nix build .#mpl` |
| `parlaylib` | Parallel algorithms library (default scheduler) | `nix build .#parlaylib` |
| `parlaylib-taskparts` | Parlaylib with taskparts scheduler | `nix build .#parlaylib-taskparts` |
| `parlaylib-taskparts-examples` | Parlaylib examples using taskparts | `nix build .#parlaylib-taskparts-examples` |
| `smlfmt` | Standard ML code formatter | `nix build .#smlfmt` |
| `taskparts` | C++ task parallelism library | `nix build .#taskparts` |

### Update Flake Inputs

To update a specific input (e.g., to get latest taskparts):
```bash
nix flake update taskparts-src
```

## Architecture

### Flake Inputs

The flake fetches sources from:
- `taskparts-src` - github:mikerainey/taskparts (successor branch)
- `flexibench-src` - github:mikerainey/flexibench (private, requires SSH)

### Package Derivations (`pkgs/`)

Each subdirectory contains a `default.nix` derivation:
- `cmdline` - Header-only library, no build required
- `flexibench` - Python package using `buildPythonPackage`
- `mpl` - Built with MLton compiler
- `parlaylib` - CMake-based, supports multiple scheduler backends
- `smlfmt` - Built with MLton compiler
- `taskparts` - CMake-based, header-only library

### Platform Support

Packages support both x86_64 and ARM64 (Apple Silicon) via platform detection flags:
- `TASKPARTS_DARWIN` / `TASKPARTS_POSIX` - OS detection
- `TASKPARTS_ARM64` / `TASKPARTS_X64` - Architecture detection

These flags are automatically set in the derivations based on `stdenv.isDarwin` and `stdenv.isAarch64`.

### Parlaylib Configuration Options

The `parlaylib` derivation accepts these parameters:
- `taskparts` - Enable taskparts scheduler backend
- `parlaySequential` - Use sequential scheduler
- `parlayExamples` - Build example programs
- `parlayInstallExamples` - Install examples to output
- `parlayFewExamples` - Build only a subset of examples (faster)
- `parlayCilkPlus` / `parlayOpenCilk` / `parlayOpenMP` - Alternative schedulers

### Taskparts Configuration Options

The `taskparts` derivation accepts:
- `statsEnable` - Enable scheduler statistics
- `loggingEnable` - Enable logging
- `disableElasticParallelism` - Disable elastic scheduling
- `hwloc` - Enable hwloc for CPU pinning
