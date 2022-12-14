% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot.R
\name{plot}
\alias{plot}
\alias{plot.mic}
\alias{autoplot.mic}
\alias{fortify.mic}
\alias{plot.disk}
\alias{autoplot.disk}
\alias{fortify.disk}
\alias{plot.rsi}
\alias{autoplot.rsi}
\alias{fortify.rsi}
\title{Plotting for Classes \code{rsi}, \code{mic} and \code{disk}}
\usage{
\method{plot}{mic}(
  x,
  mo = NULL,
  ab = NULL,
  guideline = "EUCAST",
  main = deparse(substitute(x)),
  ylab = "Frequency",
  xlab = "Minimum Inhibitory Concentration (mg/L)",
  colours_RSI = c("#ED553B", "#3CAEA3", "#F6D55C"),
  language = get_AMR_locale(),
  expand = TRUE,
  ...
)

\method{autoplot}{mic}(
  object,
  mo = NULL,
  ab = NULL,
  guideline = "EUCAST",
  title = paste("MIC values of", deparse(substitute(object))),
  ylab = "Frequency",
  xlab = "Minimum Inhibitory Concentration (mg/L)",
  colours_RSI = c("#ED553B", "#3CAEA3", "#F6D55C"),
  language = get_AMR_locale(),
  expand = TRUE,
  ...
)

\method{fortify}{mic}(object, ...)

\method{plot}{disk}(
  x,
  main = deparse(substitute(x)),
  ylab = "Frequency",
  xlab = "Disk diffusion diameter (mm)",
  mo = NULL,
  ab = NULL,
  guideline = "EUCAST",
  colours_RSI = c("#ED553B", "#3CAEA3", "#F6D55C"),
  language = get_AMR_locale(),
  expand = TRUE,
  ...
)

\method{autoplot}{disk}(
  object,
  mo = NULL,
  ab = NULL,
  title = paste("Disk zones of", deparse(substitute(object))),
  ylab = "Frequency",
  xlab = "Disk diffusion diameter (mm)",
  guideline = "EUCAST",
  colours_RSI = c("#ED553B", "#3CAEA3", "#F6D55C"),
  language = get_AMR_locale(),
  expand = TRUE,
  ...
)

\method{fortify}{disk}(object, ...)

\method{plot}{rsi}(
  x,
  ylab = "Percentage",
  xlab = "Antimicrobial Interpretation",
  main = deparse(substitute(x)),
  ...
)

\method{autoplot}{rsi}(
  object,
  title = paste("Resistance Overview of", deparse(substitute(object))),
  xlab = "Antimicrobial Interpretation",
  ylab = "Frequency",
  colours_RSI = c("#ED553B", "#3CAEA3", "#F6D55C"),
  language = get_AMR_locale(),
  ...
)

\method{fortify}{rsi}(object, ...)
}
\arguments{
\item{x, object}{values created with \code{\link[=as.mic]{as.mic()}}, \code{\link[=as.disk]{as.disk()}} or \code{\link[=as.rsi]{as.rsi()}} (or their \verb{random_*} variants, such as \code{\link[=random_mic]{random_mic()}})}

\item{mo}{any (vector of) text that can be coerced to a valid microorganism code with \code{\link[=as.mo]{as.mo()}}}

\item{ab}{any (vector of) text that can be coerced to a valid antimicrobial code with \code{\link[=as.ab]{as.ab()}}}

\item{guideline}{interpretation guideline to use, defaults to the latest included EUCAST guideline, see \emph{Details}}

\item{main, title}{title of the plot}

\item{xlab, ylab}{axis title}

\item{colours_RSI}{colours to use for filling in the bars, must be a vector of three values (in the order R, S and I). The default colours are colour-blind friendly.}

\item{language}{language to be used to translate 'Susceptible', 'Increased exposure'/'Intermediate' and 'Resistant', defaults to system language (see \code{\link[=get_AMR_locale]{get_AMR_locale()}}) and can be overwritten by setting the option \code{AMR_locale}, e.g. \code{options(AMR_locale = "de")}, see \link{translate}. Use \code{language = NULL} or \code{language = ""} to prevent translation.}

\item{expand}{a \link{logical} to indicate whether the range on the x axis should be expanded between the lowest and highest value. For MIC values, intermediate values will be factors of 2 starting from the highest MIC value. For disk diameters, the whole diameter range will be filled.}

\item{...}{arguments passed on to methods}
}
\value{
The \code{autoplot()} functions return a \code{\link[ggplot2:ggplot]{ggplot}} model that is extendible with any \code{ggplot2} function.

The \code{fortify()} functions return a \link{data.frame} as an extension for usage in the \code{\link[ggplot2:ggplot]{ggplot2::ggplot()}} function.
}
\description{
Functions to plot classes \code{rsi}, \code{mic} and \code{disk}, with support for base \R and \code{ggplot2}.
}
\details{
The interpretation of "I" will be named "Increased exposure" for all EUCAST guidelines since 2019, and will be named "Intermediate" in all other cases.

For interpreting MIC values as well as disk diffusion diameters, supported guidelines to be used as input for the \code{guideline} argument are: "EUCAST 2022", "EUCAST 2021", "EUCAST 2020", "EUCAST 2019", "EUCAST 2018", "EUCAST 2017", "EUCAST 2016", "EUCAST 2015", "EUCAST 2014", "EUCAST 2013", "EUCAST 2012", "EUCAST 2011", "CLSI 2022", "CLSI 2021", "CLSI 2020", "CLSI 2019", "CLSI 2018", "CLSI 2017", "CLSI 2016", "CLSI 2015", "CLSI 2014", "CLSI 2013", "CLSI 2012" and "CLSI 2011".

Simply using \code{"CLSI"} or \code{"EUCAST"} as input will automatically select the latest version of that guideline.
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
some_mic_values <- random_mic(size = 100)
some_disk_values <- random_disk(size = 100, mo = "Escherichia coli", ab = "cipro")
some_rsi_values <- random_rsi(50, prob_RSI = c(0.30, 0.55, 0.05))

plot(some_mic_values)
plot(some_disk_values)
plot(some_rsi_values)

# when providing the microorganism and antibiotic, colours will show interpretations:
plot(some_mic_values, mo = "S. aureus", ab = "ampicillin")
plot(some_disk_values, mo = "Escherichia coli", ab = "cipro")

\donttest{
if (require("ggplot2")) {
  autoplot(some_mic_values)
  autoplot(some_disk_values, mo = "Escherichia coli", ab = "cipro")
  autoplot(some_rsi_values)
}
}
}
