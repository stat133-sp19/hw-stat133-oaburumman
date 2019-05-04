---
title: "README.md"
author: "Omar Aburumman"
date: "May 2, 2019"
---

This workout3 was the creation of the package 'binomial'
-----------------------------------------------------
Workout03: 
The binomial package elaborates on the binomial distribution. The descriptive statistics, dataframes, lists, etc are generated in the
package. To use this particular distribution keep in mind these constraints must be held true:

*Success must be binary, only two options (fail or succeed)
*Each trial is independent of the other
*Constant probability (p, iid)
*Fixed Trials from 1 to n

Main Parameters: prob, success, trials

Class Types in Package: closure, numeric, data.frame, list, bincum, binvar, summary.binvar

Functions: 
check_prob()
– check_trials()
– check_success()
• Context for summary measures:
– aux_mean()
– aux_variance()
– aux_mode()
– aux_skewness()
– aux_kurtosis()
• Context for binomial:
– bin_choose()
– bin_probability()
– bin_distribution()
– bin_cumulative()
