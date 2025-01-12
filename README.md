# Parallel Worlds

A study of Astroturfing and Polarization in modern media

## Installation

### Nix

We have a nix flake to make a devshell. It has an install check that will tell
you if you need to install any more lexicons. Just run `nix develop` and you
should be good to go.

### Everything Else

To ensure the script runs, make sure to do the following:

- install the necessary libraries from the dependencies
- run the following snippets in **interactive mode** (not as a script)

```R
library(tidytext)
```

```R
get_sentiments("nrc")
```

```R
get_sentiments("afinn")
```

```R
get_sentiments("bing")
```

Answer yes to all three. This will install the lexicons locally to be used for
the analysis.

## Dependencies

Packages:

- `quarto`
- `R`

R libraries:

- `tidyverse`
- `tidytext`
- `textdata`
- `tm`
- `gridExtra`
- `textclean`
- `rmarkdown`
- `quarto`
- `paletteer`
- `ggthemes`
- `psych`
- `ggpmisc`
- `topicmodels`
- `ldatuning`
- `caret`
- `textclean`
- `igraph`
- `ggraph`
