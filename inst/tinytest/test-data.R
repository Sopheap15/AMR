# ==================================================================== #
# TITLE                                                                #
# Antimicrobial Resistance (AMR) Data Analysis for R                   #
#                                                                      #
# SOURCE                                                               #
# https://github.com/msberends/AMR                                     #
#                                                                      #
# LICENCE                                                              #
# (c) 2018-2022 Berends MS, Luz CF et al.                              #
# Developed at the University of Groningen, the Netherlands, in        #
# collaboration with non-profit organisations Certe Medical            #
# Diagnostics & Advice, and University Medical Center Groningen.       # 
#                                                                      #
# This R package is free software; you can freely use and distribute   #
# it for both personal and commercial purposes under the terms of the  #
# GNU General Public License version 2.0 (GNU GPL-2), as published by  #
# the Free Software Foundation.                                        #
# We created this package for both routine data analysis and academic  #
# research and it was publicly released in the hope that it will be    #
# useful, but it comes WITHOUT ANY WARRANTY OR LIABILITY.              #
#                                                                      #
# Visit our website for the full manual and a complete tutorial about  #
# how to conduct AMR data analysis: https://msberends.github.io/AMR/   #
# ==================================================================== #

expect_true(AMR:::check_dataset_integrity()) # in misc.R

# IDs should always be unique
expect_identical(nrow(microorganisms), length(unique(microorganisms$mo)))
expect_identical(class(microorganisms$mo), c("mo", "character"))
expect_identical(nrow(antibiotics), length(unique(antibiotics$ab)))
expect_true(all(is.na(antibiotics$atc[duplicated(antibiotics$atc)])))
expect_identical(class(antibiotics$ab), c("ab", "character"))


# check cross table reference
expect_true(all(microorganisms.codes$mo %in% microorganisms$mo))
expect_true(all(example_isolates$mo %in% microorganisms$mo))
expect_true(all(rsi_translation$mo %in% microorganisms$mo))
expect_true(all(rsi_translation$ab %in% antibiotics$ab))
expect_true(all(intrinsic_resistant$mo %in% microorganisms$mo))
expect_true(all(intrinsic_resistant$ab %in% antibiotics$ab))
expect_false(any(is.na(microorganisms.codes$code)))
expect_false(any(is.na(microorganisms.codes$mo)))
expect_true(all(dosage$ab %in% antibiotics$ab))
expect_true(all(dosage$name %in% antibiotics$name))
# check valid disks/MICs
expect_false(any(is.na(as.mic(rsi_translation[which(rsi_translation$method == "MIC"), "breakpoint_S"]))))
expect_false(any(is.na(as.mic(rsi_translation[which(rsi_translation$method == "MIC"), "breakpoint_R"]))))
expect_false(any(is.na(as.disk(rsi_translation[which(rsi_translation$method == "DISK"), "breakpoint_S"]))))
expect_false(any(is.na(as.disk(rsi_translation[which(rsi_translation$method == "DISK"), "breakpoint_R"]))))

# antibiotic names must always be coercible to their original AB code
expect_identical(as.ab(antibiotics$name), antibiotics$ab)

# check if all languages are included in package environmental variable
expect_identical(sort(c("en", colnames(AMR:::TRANSLATIONS)[nchar(colnames(AMR:::TRANSLATIONS)) == 2])),
                 unname(AMR:::LANGUAGES_SUPPORTED))

# there should be no diacritics (i.e. non ASCII) characters in the datasets (CRAN policy)
datasets <- data(package = "AMR", envir = asNamespace("AMR"))$results[, "Item"]
for (i in seq_len(length(datasets))) {
  dataset <- get(datasets[i], envir = asNamespace("AMR"))
  expect_identical(class(dataset), "data.frame")
  expect_identical(AMR:::dataset_UTF8_to_ASCII(dataset), dataset, info = datasets[i])
}

df <- AMR:::MO_lookup
expect_true(nrow(df[which(df$prevalence == 1), ]) < nrow(df[which(df$prevalence == 2), ]))
expect_true(nrow(df[which(df$prevalence == 2), ]) < nrow(df[which(df$prevalence == 3), ]))
expect_true(all(c("mo", "fullname",
                  "kingdom", "phylum", "class", "order", "family", "genus", "species", "subspecies",
                  "rank", "ref", "species_id", "source", "prevalence", "snomed",
                  "kingdom_index", "fullname_lower", "g_species") %in% colnames(df)))

expect_true(all(c("fullname", "fullname_new", "ref", "prevalence",
                  "fullname_lower", "g_species") %in% colnames(AMR:::MO.old_lookup)))

expect_inherits(AMR:::MO_CONS, "mo")

expect_identical(class(catalogue_of_life_version()),
                 c("catalogue_of_life_version", "list"))

expect_stdout(print(catalogue_of_life_version()))

uncategorised <- subset(microorganisms,
                        genus == "Staphylococcus" &
                          !species %in% c("", "aureus") &
                          !mo %in% c(AMR:::MO_CONS, AMR:::MO_COPS))
expect_true(NROW(uncategorised) == 0, 
            info = ifelse(NROW(uncategorised) == 0,
                          "All staphylococcal species categorised as CoNS/CoPS.",
                          paste0("Staphylococcal species not categorised as CoNS/CoPS: S. ",
                                 uncategorised$species, " (", uncategorised$mo, ")")))

# THIS WILL CHECK NON-ASCII STRINGS IN ALL FILES:

# check_non_ascii <- function() {
#   purrr::map_df(
#     .id = "file",
#     # list common text files
#     .x = fs::dir_ls(
#       recurse = TRUE,
#       type = "file",
#       # ignore images, compressed
#       regexp = "\\.(png|ico|rda|ai|tar.gz|zip|xlsx|csv|pdf|psd)$",
#       invert = TRUE
#     ),
#     .f = function(path) {
#       x <- readLines(path, warn = FALSE)
#       # from tools::showNonASCII()
#       asc <- iconv(x, "latin1", "ASCII")
#       ind <- is.na(asc) | asc != x
#       # make data frame
#       if (any(ind)) {
#         tibble::tibble(
#           row = which(ind),
#           line = iconv(x[ind], "latin1", "ASCII", sub = "byte")
#         )
#       } else {
#         tibble::tibble()
#       }
#     }
#   )
# }
# x <- check_non_ascii() %>% 
#   filter(file %unlike% "^(data-raw|docs|git_)")
