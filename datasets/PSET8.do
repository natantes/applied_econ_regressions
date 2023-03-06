
// use "C:\Dev\applied_econ_regressions\datasets\employment_08_09.dta", clear
use "/Users/natan/Dev/applied_econ_regressions/datasets/employment_08_09.dta", clear

summarize employed 
ci mean employed

/*
(1A)
all people who were surveyed were emplyed in 2008 so confidence interval 
conditional on this is simply the confidence interval of all the fraction
of employed workers in the dataset
*/

gen age2 = age * age

eststo A: logit employed age age2

/*
(1B) 

(i)
Yes, the large positive coefficent on age suggests that the log likelihood
of a unit change in age was associated with the probability of being employed

(ii)
Yes, the statistical significance on both the age and age^2 variables suggest
that there exists a nonlinear relationship, furthermore, the opposing signs
on the log likelihood suggests that there are opposing effects
*/

eststo B: logit employed age age2 earnwke educ_hs educ_lths educ_somecol educ_bac
eststo C: logit employed age age2 earnwke educ_hs educ_lths ne_states ce_states we_states

/*
(1C) 

(i)
Yes, including the two statistically sigificant regressors weekly earnings and
certain levels of educational attainment, it can be noticed that the coefficents
of the loglikehood of age and age^2 decrease by a relatievly large amount which
means that the exclusion of the other variables caused the previous coefficents
to be biased upwards.

(ii)
The types of workers that were hurt most by the Depression were those were
very young but as people get older, they were more likely to be more employed
however, this effect drops off because of the fact that the log likelihood on the
age^2 variable is negative, likewise, those with the lowest weekly earnings were 
also hurt the most since the logelikehood of those who were
*/

eststo A: logit unemployed age age2
eststo B: logit unemployed age age2 earnwke educ_hs educ_lths educ_somecol educ_bac
eststo C: logit unemployed age age2 earnwke educ_hs educ_lths ne_states ce_states we_states

/*
(1D) 


*/





// use "C:\Dev\applied_econ_regressions\datasets\Smoking.dta" // Windows
use "/Users/natan/Dev/applied_econ_regressions/datasets/Smoking.dta", clear // Mac

gen age2 = age * age
gen nosmkban = smkban != 1

summarize smoker
summarize smoker if smkban == 1
summarize smoker if nosmkban == 1
// (2A)

ttest smoker, by(smkban)
// (2B)

logit smoker smkban female age age2 hsdrop hsgrad colsome colgrad black hispanic 
/*
(2C) 
Yes, people that were affected by the smoking ban had a lower loglikehood of 
being a smoker and the result is significant at the 95% confidence level when 
testing the null hypothesis that the coefficent is equal to 0 with alpha = 0.05.
The result in part b suggested that people who were not affected by the ban
had a 28.95% chance of smoking as opposed to the 21.2% of smoking. This is
agrees with the result from the regression that the smoking ban had a negative
effect on smoking.
*/

/*
(2D) 
Yes, people who were high school dropouts were 4 times as likely to become a 
smoker when compared to college graduates since the ratio of coefficents is 4.
This suggests people with higher eduacation were less likely to smoke since
all the coefficents related to education were significant at the 95% of confidence
level. The probability of smoking decreases with higher education.
*/





// use "C:\Dev\applied_econ_regressions\datasets\Pratt.dta" // Windows
use "/Users/natan/Dev/applied_econ_regressions/datasets/Pratt.dta", clear // Mac

reg choose cars dovtt divtt dcost

logit choose card dovtt divtt dcost
