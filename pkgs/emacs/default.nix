{ emacsPackagesNgGen, emacs, notmuch }:

let
  emacsWithPackages = (emacsPackagesNgGen emacs).emacsWithPackages;
in
  emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
    magit          # ; Integrate git <C-x g>
    zerodark-theme # ; Nicolas' theme
  ]) ++ (with epkgs.melpaPackages; [
     pandoc-mode    # ; mode for interacting with pandoc
     tuareg         # ; ocaml mode
     nix-mode       # ; nix-expression mode
     markdown-mode
     haskell-mode
  ]) ++ (with epkgs.elpaPackages; [
    sml-mode       # ; Standard ML mode
    undo-tree      # ; <C-x u> to show the undo tree
    #auctex         # ; LaTeX mode
    beacon         # ; highlight my cursor when scrolling
    nameless       # ; hide current package name everywhere in elisp code
  ]) ++ [
    notmuch   # From main packages set
  ])
