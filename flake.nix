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

      # Create an R script for checking and installing lexicons
      # Create an R script for checking and installing lexicons
      checkLexicons = pkgs.writeTextFile {
        name = "check-lexicons.R";
        text = ''
          check_and_install_lexicons <- function() {
          cat("checking if lexicons are installed...\n")
            library(textdata)

            # Function to safely check if lexicon exists
            has_lexicon <- function(name) {
              tryCatch({
                tidytext::get_sentiments(name)
                TRUE
              }, error = function(e) FALSE)
            }

            # Check each lexicon
            lexicons <- c("afinn", "bing", "nrc")
            missing <- Filter(function(x) !has_lexicon(x), lexicons)

            if (length(missing) > 0) {
              cat("\nInstall the missing sentiment lexicons:\n")
              for (lex in missing) {
                cat("- ", lex, "\n")
              }
              cat("\nRun R, and then within it run:\n")
              cat("\nlibrary(tidytext)\n")
              for (lex in missing) {
              cat(sprintf('get_sentiments("%s")\n', lex))
              }
            } else {
              cat("\nAll sentiment lexicons are already installed.\n")
            }
          }

          # Run the check and install function
          check_and_install_lexicons()
        '';
      };
    in {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          rstudio
          R
          rPackages.tidyverse
          rPackages.tidytext
          rPackages.textdata
          rPackages.tm
          rPackages.fastDummies
          rPackages.ggfortify
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
          nu -e "Rscript ${checkLexicons}"
        '';
      };
    });
}
