# Works under Linux and MacOS only
# pirouette example 30:
# create one exemplary DD tree, as used in the pirouette article
# without candidate models
library(pirouette)
library(beautier)
library(ggplot2)

# Constants
example_no <- 46
folder_name <- file.path(paste0("example_", example_no))
crown_age <- 10
n_taxa <- 6
rng_seed <- 314
is_testing <- is_on_ci()

# Create phylogenies
set.seed(rng_seed)
phylogeny <- create_exemplary_dd_tree(n_taxa = n_taxa, crown_age = crown_age)

# Setup pirouette
pir_params <- create_std_pir_params(folder_name = folder_name)

# Only keep generative model
pir_params$experiments <- pir_params$experiments[1]
pir_params$evidence_filename <- NA
pir_params$twinning_params$twin_evidence_filename <- NA

if (is_testing) {
  pir_params <- shorten_pir_params(pir_params)
}

# Do the runs
pir_out <- pir_run(
  phylogeny,
  pir_params = pir_params
)

# Save summary locally
pir_outs <- list()
pir_outs[[1]] <- pir_out
pir_plots(pir_outs) +
  ggtitle(paste0("pirouette example ", example_no)) +
  ggsave("errors.png", width = 7, height = 7)

# Save results in folder(s) (that have no version version)
pir_save(
  phylogeny = phylogeny,
  pir_params = pir_params,
  pir_out = pir_out,
  folder_name = folder_name
)

