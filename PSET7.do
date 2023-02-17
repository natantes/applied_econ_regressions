
// QUESTION 1

use "C:\Dev\applied_econ_regressions\datasets\Names.dta", clear

gen white = (black != 1)

// (1A)
logistic call_back black, r
logistic call_back white, r

// (1B)
gen blackxfemale = black * female
gen whitexfemale = white * female
logistic call_back blackxfemale, r
logistic call_back whitexfemale, r

// (1B)
gen highxwhite = high * (black != 1)
gen highxblack = high * black
logistic call_back highxwhite
logistic call_back highxblack

// QUESTION 2

use "C:\Dev\applied_econ_regressions\datasets\dc_cocaine.dta", clear