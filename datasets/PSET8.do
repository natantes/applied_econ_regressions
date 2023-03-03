
use "C:\Dev\applied_econ_regressions\datasets\employment_08_09.dta", clear

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


(ii)
*/

eststo B: logit employed age age2 earnwke educ_hs educ_lths educ_somecol educ_bac
eststo C: logit employed age age2 earnwke educ_hs educ_lths ne_states ce_states we_states

/*
(1C) 

(i)


(ii)
*/

eststo A: logit unemployed age age2
eststo B: logit unemployed age age2 earnwke educ_hs educ_lths educ_somecol educ_bac
eststo C: logit unemployed age age2 earnwke educ_hs educ_lths ne_states ce_states we_states

/*
(1D) 


*/


use "C:\Dev\applied_econ_regressions\datasets\Smoking.dta"

use "C:\Dev\applied_econ_regressions\datasets\Pratt.dta"