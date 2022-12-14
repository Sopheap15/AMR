% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/key_antimicrobials.R
\name{key_antimicrobials}
\alias{key_antimicrobials}
\alias{all_antimicrobials}
\alias{antimicrobials_equal}
\title{(Key) Antimicrobials for First Weighted Isolates}
\usage{
key_antimicrobials(
  x = NULL,
  col_mo = NULL,
  universal = c("ampicillin", "amoxicillin/clavulanic acid", "cefuroxime",
    "piperacillin/tazobactam", "ciprofloxacin", "trimethoprim/sulfamethoxazole"),
  gram_negative = c("gentamicin", "tobramycin", "colistin", "cefotaxime",
    "ceftazidime", "meropenem"),
  gram_positive = c("vancomycin", "teicoplanin", "tetracycline", "erythromycin",
    "oxacillin", "rifampin"),
  antifungal = c("anidulafungin", "caspofungin", "fluconazole", "miconazole",
    "nystatin", "voriconazole"),
  only_rsi_columns = FALSE,
  ...
)

all_antimicrobials(x = NULL, only_rsi_columns = FALSE, ...)

antimicrobials_equal(
  y,
  z,
  type = c("points", "keyantimicrobials"),
  ignore_I = TRUE,
  points_threshold = 2,
  ...
)
}
\arguments{
\item{x}{a \link{data.frame} with antibiotics columns, like \code{AMX} or \code{amox}. Can be left blank to determine automatically}

\item{col_mo}{column name of the IDs of the microorganisms (see \code{\link[=as.mo]{as.mo()}}), defaults to the first column of class \code{\link{mo}}. Values will be coerced using \code{\link[=as.mo]{as.mo()}}.}

\item{universal}{names of \strong{broad-spectrum} antimicrobial agents, case-insensitive. Set to \code{NULL} to ignore. See \emph{Details} for the default agents.}

\item{gram_negative}{names of antibiotic agents for \strong{Gram-positives}, case-insensitive. Set to \code{NULL} to ignore. See \emph{Details} for the default agents.}

\item{gram_positive}{names of antibiotic agents for \strong{Gram-negatives}, case-insensitive. Set to \code{NULL} to ignore. See \emph{Details} for the default agents.}

\item{antifungal}{names of antifungal agents for \strong{fungi}, case-insensitive. Set to \code{NULL} to ignore. See \emph{Details} for the default agents.}

\item{only_rsi_columns}{a \link{logical} to indicate whether only columns must be included that were transformed to class \verb{<rsi>} (see \code{\link[=as.rsi]{as.rsi()}}) on beforehand (defaults to \code{FALSE})}

\item{...}{ignored, only in place to allow future extensions}

\item{y, z}{\link{character} vectors to compare}

\item{type}{type to determine weighed isolates; can be \code{"keyantimicrobials"} or \code{"points"}, see \emph{Details}}

\item{ignore_I}{\link{logical} to indicate whether antibiotic interpretations with \code{"I"} will be ignored when \code{type = "keyantimicrobials"}, see \emph{Details}}

\item{points_threshold}{minimum number of points to require before differences in the antibiogram will lead to inclusion of an isolate when \code{type = "points"}, see \emph{Details}}
}
\description{
These functions can be used to determine first weighted isolates by considering the phenotype for isolate selection (see \code{\link[=first_isolate]{first_isolate()}}). Using a phenotype-based method to determine first isolates is more reliable than methods that disregard phenotypes.
}
\details{
The \code{\link[=key_antimicrobials]{key_antimicrobials()}} and \code{\link[=all_antimicrobials]{all_antimicrobials()}} functions are context-aware. This means that the \code{x} argument can be left blank if used inside a \link{data.frame} call, see \emph{Examples}.

The function \code{\link[=key_antimicrobials]{key_antimicrobials()}} returns a \link{character} vector with 12 antimicrobial results for every isolate. The function \code{\link[=all_antimicrobials]{all_antimicrobials()}} returns a \link{character} vector with all antimicrobial results for every isolate. These vectors can then be compared using \code{\link[=antimicrobials_equal]{antimicrobials_equal()}}, to check if two isolates have generally the same antibiogram. Missing and invalid values are replaced with a dot (\code{"."}) by \code{\link[=key_antimicrobials]{key_antimicrobials()}} and ignored by \code{\link[=antimicrobials_equal]{antimicrobials_equal()}}.

Please see the \code{\link[=first_isolate]{first_isolate()}} function how these important functions enable the 'phenotype-based' method for determination of first isolates.

The default antimicrobial agents used for \strong{all rows} (set in \code{universal}) are:
\itemize{
\item Ampicillin
\item Amoxicillin/clavulanic acid
\item Cefuroxime
\item Ciprofloxacin
\item Piperacillin/tazobactam
\item Trimethoprim/sulfamethoxazole
}

The default antimicrobial agents used for \strong{Gram-negative bacteria} (set in \code{gram_negative}) are:
\itemize{
\item Cefotaxime
\item Ceftazidime
\item Colistin
\item Gentamicin
\item Meropenem
\item Tobramycin
}

The default antimicrobial agents used for \strong{Gram-positive bacteria} (set in \code{gram_positive}) are:
\itemize{
\item Erythromycin
\item Oxacillin
\item Rifampin
\item Teicoplanin
\item Tetracycline
\item Vancomycin
}

The default antimicrobial agents used for \strong{fungi} (set in \code{antifungal}) are:
\itemize{
\item Anidulafungin
\item Caspofungin
\item Fluconazole
\item Miconazole
\item Nystatin
\item Voriconazole
}
}
\section{Stable Lifecycle}{

\if{html}{\figure{lifecycle_stable.svg}{options: style=margin-bottom:"5"} \cr}
The \link[=lifecycle]{lifecycle} of this function is \strong{stable}. In a stable function, major changes are unlikely. This means that the unlying code will generally evolve by adding new arguments; removing arguments or changing the meaning of existing arguments will be avoided.

If the unlying code needs breaking changes, they will occur gradually. For example, an argument will be deprecated and first continue to work, but will emit a message informing you of the change. Next, typically after at least one newly released version on CRAN, the message will be transformed to an error.
}

\section{Read more on Our Website!}{

On our website \url{https://msberends.github.io/AMR/} you can find \href{https://msberends.github.io/AMR/articles/AMR.html}{a comprehensive tutorial} about how to conduct AMR data analysis, the \href{https://msberends.github.io/AMR/reference/}{complete documentation of all functions} and \href{https://msberends.github.io/AMR/articles/WHONET.html}{an example analysis using WHONET data}.
}

\examples{
# `example_isolates` is a data set available in the AMR package.
# See ?example_isolates.

# output of the `key_antimicrobials()` function could be like this:
strainA <- "SSSRR.S.R..S"
strainB <- "SSSIRSSSRSSS"

# those strings can be compared with:
antimicrobials_equal(strainA, strainB, type = "keyantimicrobials")
# TRUE, because I is ignored (as well as missing values)

antimicrobials_equal(strainA, strainB, type = "keyantimicrobials", ignore_I = FALSE)
# FALSE, because I is not ignored and so the 4th [character] differs

\donttest{
if (require("dplyr")) {
  # set key antibiotics to a new variable
  my_patients <- example_isolates \%>\%
    mutate(keyab = key_antimicrobials(antifungal = NULL)) \%>\% # no need to define `x`
    mutate(
      # now calculate first isolates
      first_regular = first_isolate(col_keyantimicrobials = FALSE),
      # and first WEIGHTED isolates
      first_weighted = first_isolate(col_keyantimicrobials = "keyab")
    )
 
  # Check the difference, in this data set it results in more isolates:
  sum(my_patients$first_regular, na.rm = TRUE)
  sum(my_patients$first_weighted, na.rm = TRUE)
}
}
}
\seealso{
\code{\link[=first_isolate]{first_isolate()}}
}
