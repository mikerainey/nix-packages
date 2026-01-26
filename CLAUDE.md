# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Nix package repository containing derivations for parallel computing libraries and tools, primarily focused on the Deepsea/CMU Parlay ecosystem.

## Build Commands

Build a package directly from its derivation:
```bash
nix-build pkgs/<package-name>/default.nix
```

## Architecture

**Package Derivations (`pkgs/`):**
Each subdirectory contains a `default.nix` derivation. Available packages:
- `cmdline` - Command-line parsing header library
- `flexibench` - CLI tool for benchmarking software (Python package)
- `mpl` - MaPLe compiler for Parallel ML (built with MLton)
- `parlaylib` - Parallel algorithms library with multiple scheduler backends
- `smlfmt` - Standard ML code formatter
- `taskparts` - C++ task parallelism library with configurable CMake flags

**Source Dependencies:**
Several packages expect sibling directories for local development:
- `taskparts` expects `../successor`
- `parlaylib` examples expect `../parlaylib`
