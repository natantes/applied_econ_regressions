
// QUESTION 1
// use "/Users/natan/Dev/applied_econ_regressions/datasets/Names.dta", clear
use "C:\Dev\applied_econ_regressions\datasets\Names.dta", clear

gen white = (black == 0)

// (1A)
reg call_back black, r
// the call_back rate for white people was 9.65% and the call back rate for
// african americans was 6.80%. The 95% confidence interval for the difference
// is simply the interval of the dummy which is [-0.0384, -0.00799]. Since 0
// is not within the inteval, the result is statistically significant because
// it is significantly different from 0 at the 95% confidence level. A 3.2% 
// decrease is very large difference in the real world sense given all else equal.

// (1B)
gen blackxfemale = black * female
gen whitexfemale = white * female
reg call_back whitexfemale blackxfemale, r
lincom _b[whitexfemale] - _b[blackxfemale]
// the call backrate for white females is 9.88% and the callback rate for 
// black females was 6.62%, the difference 0.03264 and it is significantly
// different from 0


// (1C)
gen highxwhite = high * (black != 1)
gen highxblack = high * black
reg call_back highxwhite highxblack, r
lincom _b[highxwhite] - _b[highxblack]
// TO DO MENTION SIGNIFICANCE

// (1D)
reg black high honors volunteer computerskills email workinschool yearsexp, r
// Based on the regressions, there is no significant covariance between most
// of the aspects of the resumes because all of the coefficents of the
// are insignificant at the 90% of the significance level. However, the
// variable "computerskills" actually has significant covariance with black
// resumes which may suggest that there may exist some nonrandom assignment


// QUESTION 2

use "C:\Dev\applied_econ_regressions\datasets\dc_cocaine.dta", clear
// use "/Users/natan/Dev/applied_econ_regressions/datasets/dc_cocaine.dta", clear

// (2A)
reg lrprc lqty lpure if (year == 92 & dea == 1), r

// (2B)
reg lrprc lqty lpure if (year == 92 & mpdc == 1), r

// (2C)
// Yes, the significant negative coefficent on quantity suggests that the 
// quantity discounting exists in the market

reg lrprc lqty lpure dea if (year == 92), r

// (2D)
// By running the previous the regression, it can be observed that the
// coefficent on the dea dummy is significant at the 95% and 99% significance
// levels so there does exist a difference in the average prices paid

reg lrprc lqty lpure if (year == 92 & dea == 1), r
ovtest

reg lrprc lqty lpure if (year == 92 & mpdc == 1), r
ovtest

// (2E)
// The dea model may have misspecification because when using the Ramsey
// RESET test, the null hypothesis that there not omitted variables is unable
// to be rejected at the 95% and 90% significance levels. However, using the
// the Ramsey Test on the mpdc model, it is found that the null hypothesis is 
// rejected at 95% and 99% significance levels so there is not clear evidence
// that there is misspecification based on the RESET test.

