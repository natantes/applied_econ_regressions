
// QUESTION 1
use "/Users/natan/Dev/applied_econ_regressions/datasets/Names.dta", clear

gen white = (black != 1)

// (1A)
logistic call_back black, r
logistic call_back white, r

// (1B)
gen blackxfemale = black * female
gen whitexfemale = white * female
logistic call_back blackxfemale, r
logistic call_back whitexfemale, r

// (1C)
gen highxwhite = high * (black != 1)
gen highxblack = high * black
logistic call_back highxwhite
logistic call_back highxblack

// (1D)
logistic high black
corr black high
logistic high white


// QUESTION 2

// use "C:\Dev\applied_econ_regressions\datasets\dc_cocaine.dta", clear
use "/Users/natan/Dev/applied_econ_regressions/datasets/dc_cocaine.dta", clear

// (2A)

reg lrprc lqty lpure if (year == 92 & dea == 1), r

reg lrprc lqty lpure if (year == 92 & mpdc == 1), r

reg lrprc lqty lpure dea if (year == 92), r

// By running the previous the regression, it can be observed that the
// coefficent on the dea dummy is significant at the 95% and 99% significance
// levels so there does exist a difference in the average prices paid

reg lrprc lqty lpure if (year == 92 & dea == 1), r
ovtest

reg lrprc lqty lpure if (year == 92 & mpdc == 1), r
ovtest

// (1E)
// The dea model may have misspecification because when using the Ramsey
// RESET test, the null hypothesis that there not omitted variables is unable
// to be rejected at the 95% and 90% significance levels. However, using the
// the Ramsey Test on the mpdc model, it is found that the null hypothesis is 
// rejected at 95% and 99% significance levels so there is not clear evidence
// that there is misspecification based on the RESET test.

