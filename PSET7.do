
// QUESTION 1
// use "/Users/natan/Dev/applied_econ_regressions/datasets/Names.dta", clear
use "C:\Dev\applied_econ_regressions\datasets\Names.dta", clear

gen white = (black == 0)
gen male = (female == 0)

eststo OLS1: reg call_back black, r
esttab OLS1, onecell mtitles("m1") cells(b(star fmt(3)) se(par fmt(2))) legend label varlabels(_cons Constant) stats(r2)
// (1A)
// the call_back rate for white people was 9.65% and the call back rate for
// african americans was 6.80%. The 95% confidence interval for the difference
// is simply the interval of the dummy which is [-0.0384, -0.00799]. Since 0
// is not within the inteval, the result is statistically significant because
// it is significantly different from 0 at the 95% confidence level. A 3.2% 
// decrease is very large difference in the real world sense given all else equal.

gen blackxfemale = black * female
gen whitexfemale = white * female
gen whitexhigh = high * (black != 1)
gen highxwhite = high * (black != 1)
gen highxblack = high * black
gen whitexmale = white * male
// eststo OLS2: quietly reg call_back whitexfemale blackxfemale, r
// esttab OLS2, onecell mtitles("m2") cells(b(star fmt(3)) se(par fmt(2))) legend label varlabels(_cons Constant) stats(r2)
// lincom _b[whitexfemale] - _b[blackxfemale]
eststo OLS3: reg call_back white##male, r
eststo OLS4: reg call_back white##high, r
eststo OLS3: reg call_back white male whitexmale, r
eststo OLS4: reg call_back white high whitexhigh, r
esttab OLS3 OLS4, onecell mtitles("m3" "m4") cells(b(star fmt(3)) se(par fmt(2))) legend label varlabels(_cons Constant) stats(r2)
// (1B)
// the call back rate differntial between African American/White is not 
// significantly different for men than for women. Running a difference in 
// differences regression, the coefficent on whitexmale suggests that the
// differntial is not significant different from 0 at 95% and 90% significance
// levels. The differntial for between African American/White is not 
// significantly different for high quality/ low quality resumes at the 95%
// and 90% significane levels as well by testing the null hypothesis in m4 
// that the coefficent on whitexhigh is significantly differnent from 0. This
// suggests that the disciminatory effects occur homogenously across male/female 
// and low/high quality reusmes



eststo OLS5: reg call_back black highxblack highxwhite, r
lincom (_b[highxwhite]) - (_b[highxblack])
esttab OLS5, onecell mtitles("m5") cells(b(star fmt(3)) se(par fmt(2))) legend label varlabels(_cons Constant) stats(r2)
// (1C)
// the high low quality difference from whites is 0.023 and for african americans
// is 0.0051, testing the difference using lincom, we get the same result from
// "1B" using difference in differences. The high/low quality differential is
// is not signifiacntly different for white vs african american resumes and this
// result is not significant at the 95% and 90% significance levels. 

eststo OLS5: quietly reg black high honors volunteer computerskills email workinschool yearsexp, r
esttab OLS5, onecell mtitles("m5") cells(b(star fmt(3)) se(par fmt(2))) legend label varlabels(_cons Constant) stats(r2)
// (1D)
// Based on the regressions, there is no significant covariance between most
// of the aspects of the resumes because all of the coefficents of the
// are insignificant at the 90% of the significance level. However, the
// variable "computerskills" actually has significant covariance with black
// resumes which may suggest that there may exist some nonrandom assignment


// QUESTION 2

use "C:\Dev\applied_econ_regressions\datasets\dc_cocaine.dta", clear
// use "/Users/natan/Dev/applied_econ_regressions/datasets/dc_cocaine.dta", clear

// (2A)
eststo OLS1: quietly reg lrprc lqty lpure if (year == 92 & dea == 1), r

// (2B)
eststo OLS2: quietly reg lrprc lqty lpure if (year == 92 & mpdc == 1), r

esttab OLS1 OLS2, onecell mtitles("m1" "m2") cells(b(star fmt(3)) se(par fmt(2))) legend label varlabels(_cons Constant) stats(r2)


// (2C)
// Yes, the significant negative coefficent on quantity suggests that the 
// quantity discounting exists in the market

eststo OLS1: quietly reg lrprc lqty lpure dea if (year == 92), r
esttab OLS1, onecell mtitles("m1") cells(b(star fmt(3)) se(par fmt(2))) legend label varlabels(_cons Constant) stats(r2)


// (2D)
// By running the previous the regression, it can be observed that the
// coefficent on the dea dummy is significant at the 95% and 99% significance
// levels so there does exist a difference in the average prices paid

eststo OLS1: quietly reg lrprc lqty lpure if (year == 92 & dea == 1), r
ovtest

eststo OLS2: quietly reg lrprc lqty lpure if (year == 92 & mpdc == 1), r
ovtest

esttab OLS1 OLS2, onecell mtitles("m1" "m2") cells(b(star fmt(3)) se(par fmt(2))) legend label varlabels(_cons Constant) stats(r2)
// (2E)
// The dea model may have misspecification because when using the Ramsey
// RESET test, the null hypothesis that there not omitted variables is unable
// to be rejected at the 95% and 90% significance levels. However, using the
// the Ramsey Test on the mpdc model, it is found that the null hypothesis is 
// rejected at 95% and 99% significance levels so there is not clear evidence
// that there is misspecification based on the RESET test.


// QUESTION 3

use "C:\Dev\applied_econ_regressions\datasets\injury.dta", clear

eststo OLS1: quietly reg ldurat afchnge highearn afhigh
esttab OLS1, onecell mtitles("m1") cells(b(star fmt(3)) se(par fmt(2))) legend label varlabels(_cons Constant) stats(r2)
display (exp(_b[afhigh]) - 1) * 100

// the percentage increase is the coefficient of the dummy of the interaction 
// variable of the Diff-in-Diff model. This suggests that after the "treatment" 
// or Kentucky cap on workers' compensation, there was indeed an increase in the
// duration of time spent on injury the leave, the the percent increase is 
// (exp(_b[afhigh]) - 1) * 100 = 20.72% for high earners.


