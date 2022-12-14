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

# Check if these functions still exist in their package (all are in Suggests field)
# Since GitHub Actions runs every night, we will get emailed when a dependency fails based on this unit test

# functions used by import_fn()
import_functions <- c(
  "anti_join" = "dplyr",
  "cur_column" = "dplyr",
  "full_join" = "dplyr",
  "has_internet" = "curl",
  "html_attr" = "rvest",
  "html_children" = "rvest",
  "html_node" = "rvest",
  "html_nodes" = "rvest",
  "html_table" = "rvest",
  "html_text" = "rvest",
  "inner_join" = "dplyr",
  "insertText" = "rstudioapi",
  "left_join" = "dplyr",
  "new_pillar_shaft_simple" = "pillar",
  "progress_bar" = "progress",
  "read_html" = "xml2",
  "right_join" = "dplyr",
  "semi_join" = "dplyr",
  "showQuestion" = "rstudioapi")
# functions that are called directly

call_functions <- c(
  # cleaner
  "freq.default" = "cleaner",
  # readxl
  "read_excel" = "readxl",
  # ggplot2
  "aes" = "ggplot2",
  "aes_string" = "ggplot2",
  "arrow" = "ggplot2",
  "autoplot" = "ggplot2",
  "element_blank" = "ggplot2",
  "element_line" = "ggplot2",
  "element_text" = "ggplot2",
  "expand_limits" = "ggplot2",
  "facet_wrap" = "ggplot2",
  "geom_errorbar" = "ggplot2",
  "geom_path" = "ggplot2",
  "geom_point" = "ggplot2",
  "geom_ribbon" = "ggplot2",
  "geom_segment" = "ggplot2",
  "geom_text" = "ggplot2",
  "ggplot" = "ggplot2",
  "labs" = "ggplot2",
  "layer" = "ggplot2",
  "position_fill" = "ggplot2",
  "scale_fill_manual" = "ggplot2",
  "scale_y_continuous" = "ggplot2",
  "theme" = "ggplot2",
  "theme_minimal" = "ggplot2",
  "unit" = "ggplot2",
  "xlab" = "ggplot2",
  "ylab" = "ggplot2"
)
if (AMR:::pkg_is_available("skimr", also_load = FALSE, min_version = "2.0.0")) {
  call_functions <- c(call_functions,
                      # skimr
                      "inline_hist" = "skimr",
                      "sfl" = "skimr")
}

extended_functions <- c(
  "freq" = "cleaner",
  "autoplot" = "ggplot2",
  "pillar_shaft" = "pillar",
  "get_skimmers" = "skimr",
  "type_sum" = "tibble",
  "vec_cast" = "vctrs",
  "vec_ptype2" = "vctrs"
)

import_functions <- c(import_functions, call_functions, extended_functions)
for (i in seq_len(length(import_functions))) {
  fn <- names(import_functions)[i]
  pkg <- unname(import_functions[i])
  # function should exist in foreign pkg namespace
  if (AMR:::pkg_is_available(pkg,
                             also_load = FALSE,
                             min_version = if (pkg == "dplyr") "1.0.0" else NULL)) {
    tst <- !is.null(AMR:::import_fn(name = fn, pkg = pkg, error_on_fail = FALSE))
    expect_true(tst,
                info = ifelse(tst,
                              "All external function references exist.",
                              paste0("Function ", pkg, "::", fn, "() does not exist anymore")))
  }
}
