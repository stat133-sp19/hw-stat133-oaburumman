#Three Private Aux Functions Written Below
#Check_prob function ensures that your probability falls between 0 and 1
#Check_trials ensures that you have non negative integer trials being tested
#Check_success tests whether success is a valid input in R between 0 to n
check_prob <- function(prob){

  if (prob > 1 | prob < 0 | length(prob)>1){
    stop("p has to be a number in between 0 and 1, only one value as well")
  } 
    return(TRUE)
}

check_trials <- function(trials){
  if (trials >0 && trials%%1 == 0){
    return(TRUE)}
  else{
    stop("invalid trial numbers") }
}

check_success <- function(success, trials){
  for (i in 1:length(trials)){
    if (success[i] < 0 || success[i] > trials){
      stop("invalid success value")}

    else if (success[i] >= 0 && success[i]<= trials)
      return(TRUE)}
}


#Part 2 Auxillary Functions
#Mean, Variance, Mode all forms of statistics whose functions are created to find them for the data
#Skewness and Kurtosis give measurements to the shape of the data, in what it's following
#No Checker function required
#Invoked in Main Functions
aux_mean <- function(trials, prob){

  bin_aux_mean = trials*prob
  return(bin_aux_mean)
}
aux_variance <- function(trials, prob){
  bin_aux_variance = trials*prob*(1-prob)
  return(bin_aux_variance)
}

aux_mode <- function(trials, prob) {
  binomial_aux_mode = trials*prob + prob

  if (binomial_aux_mode%%1 == 0) {
    odd_mode = c(binomial_aux_mode, binomial_aux_mode-1)
    return(odd_mode)}

  else{
    return(trials*prob + prob)
  }
}

aux_skewness <- function(trials, prob){
  bin_aux_skewness = (1-2*prob)/sqrt(trials*prob*(1-prob))
  return(bin_aux_skewness)
}

aux_kurtosis <- function(trials, prob){
  bin_aux_kurt = (1-6*prob*(1-prob))/(trials*prob*(1-prob))
  return(bin_aux_kurt)
}



#Part 3: Creation of the Bin_Choose() Function
#' @title factor in the binomial formula
#' @description function that creates the combinations for n and k w/o using choose
#' @param trials number of trials
#' @param success number of successes
#' @bin_combos how many possible ways can I achieve n successes in k trials
#' @export
#' @examples
#'bin_combos = factorial(n)/(factorial(k)*factorial(n-k))
#' @return a certain number of combinations
bin_choose <- function(trials,success){
  if (trials >= success){
    bin_combos = factorial(trials)/(factorial(success)*factorial(trials-success))
    return(bin_combos)}
  if (success > trials) {
    stop("k cannot be greater than n")
  }
}

#Part 4:Creation of Bin_Probability() Function
#' @title The entire Binomial Formula with n independent trials and binary options
#' @description Outputs probability using the Binomial Formula with param prob, successes and trials
#' @param success how many successes can be measured in n trials
#' @param trials how many times was the experiment repeated
#' @param prob the probability of a success occurring
#' @binomial_fomula gives a probability of k success occurring in n trials with a given prob for success
#' @examples
#'binomial_formula = bin_choose(n, k) * ((prob)^(success))* (1-prob)^(trials-success)
#' @return a certain probability
#' @export
bin_probability <- function(success, trials, prob){
  check_trials(trials)
  check_prob(prob)
  check_success(success, trials)
  binomial_formula = bin_choose(trials, success) * ((prob)^(success))* (1-prob)^(trials-success)
  return(binomial_formula)
}

#' @title Creates a Data Frame for prob depending on n and k
#' @description An output of a dataframe and its plot over a course of n trials
#' @param trials how many times was the experiment repeated
#' @param prob the probability of a success occurring
#' @bin_dataframe the data frame variable
#' @examples
#' bin_dataframe <- data.frame(bin_probability(success, trials, prob))
#' @return a data frame with successes and trials
#' @export
library(ggplot2)
bin_distributions <- function(trials, prob){
  #bin_probability(success, trials, prob)
  success <- c(0:trials)
  probability <- c(bin_choose(trials, 0:trials)*((prob)^(0:trials))* (1-prob)^(trials-(0:trials)))
  bin_dataframe <- data.frame(bin_probability(success, trials, prob))
  bin_dataframe <- cbind(success, probability)
  bin_dataframe <- data.frame(bin_dataframe)
  bin_dataframe
}

#' @export
plot.bindis <- function(bin_dataframe){
  ggplot(data = bin_dataframe, aes(x=success, y=probability)) + geom_bar(stat= "identity")
}

#' @title Finds the cumulative probability of a distribution (CDF)
#' @description Data frame with an additional cdf column
#' @param trials how many times was the experiment repeated
#' @param prob the probability of a success ocurring
#' @examples
#' cumulative = cumsum(probability)
#' @return a dataframe like functions above but with additional cumulative function
#' @export

bin_cumulative <- function(trials, prob){
  success <- c(0:trials)
  probability <- c(bin_choose(trials, 0:trials)*((prob)^(0:trials))* (1-prob)^(trials-(0:trials)))
  bin_dataframe <- data.frame(bin_probability(success, trials, prob))
  for (i in 0:success){
    cumulative = cumsum(probability)
  }
  bincum_dataframe <- cbind(success, probability, cumulative)
  bincum_dataframe <- data.frame(bincum_dataframe)
  class(bincum_dataframe) = c("bincum", "data.frame")
  bincum_dataframe
}


#' @export
plot.bincum<-function(bincum_dataframe){
  ggplot(data = bincum_dataframe, aes(x=success, y=cumulative)) + geom_line() +
    scale_y_continuous(limits = c(0,1)) + geom_point() + ylab("Probability")
}

#1.7 Bin_Variable
#' @title
#' @description
#' @param trials how many times was the experiment repeated
#' @param prob probability to get a success
#' @example
#' binvar <- list(trials, prob)
#' @return a list of trials and probabilities
#' @export

bin_variable <-function(trials, prob){
  check_trials(trials)
  check_prob(prob)
  #trials = trials
  #prob = prob
  binvar <- list('trials'= trials, 'prob' = prob)
  class(binvar) = "binvar"

  binvar

}

#' @export
print.binvar <- function(binvar){
  cat('"Binomial variable" \n\n')
  cat('Parameters \n')
  cat("- number of trials:", binvar$trials, '\n')
  cat("- prob of success :", binvar$prob, '\n\n')
}

#' @export
summary.binvar <- function(binvar){
  summary_bin <- list(
    trials <- binvar$trials,
    prob <- binvar$prob,
    mean <- aux_mean(binvar$trials, binvar$prob),
    variance <- aux_variance(binvar$trials, binvar$prob),
    mode <- aux_mode(binvar$trials, binvar$prob),
    skewness <- aux_skewness(binvar$trials, binvar$prob),
    kurtosis <- aux_kurtosis(binvar$trials, binvar$prob)
  )
  class(summary_bin) = "summary_bin"
  summary_bin
}

#' @export
print.summary.binvar <- function(summary_bin){
  cat('"Binomial variable" \n\n')
  cat('Parameters \n')
  cat("- number of trials:", summary_bin[[1]], '\n')
  cat("- prob of success :", summary_bin[[2]], '\n\n')
  cat('Measures \n')
  cat('-mean: ', summary_bin[[3]], '\n')
  cat('-variance: ', summary_bin[[4]], '\n')
  cat('-mode: ', summary_bin[[5]], '\n')
  cat('-skewness: ', summary_bin[[6]], '\n')
  cat('-kurtosis: ', summary_bin[[7]], '\n')
}

#1.8
#' @title
#' @description
#' @param trials trials of exp
#' @param prob probability
#' @export
bin_mean <- function(trials, prob){
  aux_mean(trials, prob)
}
bin_variance <- function(trials, prob){
  aux_variance(trials,prob)
}

bin_mode <- function(trials, prob){
  aux_mode(trials, prob)
}

bin_skewness <- function(trials, prob){
  aux_skewness(trials, prob)
}

bin_kurt <- function(trials, prob){
  aux_kurtosis(trials, prob)
}

