% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/all_functions_workout3.R
\name{bin_probability}
\alias{bin_probability}
\title{The entire Binomial Formula with n independent trials and binary options}
\usage{
bin_probability(success, trials, prob)
}
\arguments{
\item{success}{how many successes can be measured in n trials}

\item{trials}{how many times was the experiment repeated}

\item{prob}{the probability of a success occurring}
}
\value{
a certain probability
}
\description{
Outputs probability using the Binomial Formula with param prob, successes and trials
}
\examples{
binomial_formula = bin_choose(n, k) * ((prob)^(success))* (1-prob)^(trials-success)
}
