library(testthat)
source("all_functions_workout3.R")
context("Binomial")
test_that("make sure check functions return correct value", {
   
  expect_true(check_prob(0.6))
  expect_error(check_prob(c(-1, 2)))
  expect_error(check_prob(-1))
  expect_true(check_trials(23))
  expect_error(check_trials(-1))
  expect_error(check_success(("binomial")))
  expect_error(check_success(3, 0.22))
  expect_true(check_success(c(0,2,4), 0.22))
  expect_error(check_success(-1, -0.9))
})

test_that("Make Sure Mean Values are Correct", {
    expect_equal(aux_mean(10, 0.3), 3)
    expect_error(aux_mean(-0.2))
    expect_type(aux_mean, "closure")})

test_that("Make Sure Variance are Correct", {    
    expect_equal(aux_variance(10, 0.3), 2.1)
    expect_error(aux_variance(-0.5))
    expect_type(aux_variance, "closure")})

test_that("Make Sure Mode is Right",{    
    expect_type(aux_mode, "closure")
    expect_equal(aux_mode(10, 0.3), 3.3)
    expect_error(aux_mode(-0.22))
})

test_that("Make Sure Skewness and Kurt are Correct",{
  prob = 0.5
  trials = 2
  sku = (1-2*prob)/sqrt(trials*prob*(1-prob))
  ku = (1-6*prob*(1-prob))/(trials*prob*(1-prob))
    expect_gt(aux_skewness(10, 0.3), 0.2760262)
    expect_equal(aux_skewness(2, 0.5), sku)
    expect_type(aux_mean, "closure")
    
    expect_lt(aux_kurtosis(2, 0.25), -0.3333333)
    expect_equal(aux_kurtosis(2, 0.5), ku)
    expect_type(aux_kurtosis,"closure")
      })

test_that("Context for Binomial",{
  expect_equal(bin_choose(5,4), 5)
  expect_error(bin_choose(2,5))
  expect_type(bin_choose, "closure")
  expect_equal(bin_probability(2, 5, 0.5), 0.3125)
  expect_error(bin_probability(2,5, 1.09))
  expect_type(bin_probability, "closure")
  expect_type(bin_distributions, "closure")
  expect_error(bin_distribution(10, -0.5))
  expect_is(bin_cumulative(10, 0.3), c("bincum", "data.frame"))
  expect_error(bin_cumulative(10, -5))
})    