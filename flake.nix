{
  description = "flake for writing in r";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      inherit (self) outputs;
      pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
    in {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          rstudio
          R
          rPackages.tidyverse
          rPackages.tidytext
          rPackages.textdata
          rPackages.tm
          rPackages.gridExtra
          rPackages.textclean
          rPackages.rmarkdown
          rPackages.quarto
          rPackages.paletteer
          rPackages.ggthemes
          rPackages.psych
          rPackages.ggpmisc
          rPackages.topicmodels
          rPackages.ldatuning
          rPackages.caret
          rPackages.textclean
          rPackages.igraph
          rPackages.ggraph
          quarto
        ];
        shellHook = ''
          nu
        '';
      };
    });
}
