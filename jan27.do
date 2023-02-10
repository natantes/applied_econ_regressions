


 
 
 // Part 3: Prediction in log-lin (or log log) models 


// Linear Model
*cd "/Users/gaston/Google Drive/TAing Classes/383 - Horowitz/TA Sessions/1. 2020/2:7"
clear
use caschool.dta

/* To start, we will look at the relationship between testscores and average 
income. Is this relationship linear? */

reg testscr avginc, robust
eststo reg_a
 
esttab reg_a

predict y_linear /* we store the regression line */
label variable y_linear "y_linear"
predict u_linear, resid /* and the resudials */

scatter y_linear testscr avginc, sort connect(l) symbol(i) 

/* for high levels of 
income the regression line systematically overpredicts. This is not a great fit*/

scatter u_linear avginc 
/* residuals are not evenly distributed around zero for high levels of income */

ci mean u_linear if avginc>=40 
/* the mean of resuduals for high levels of  income is statistically greater than zero! */


 // Log-linear: a unit-change in x is associated with a change in y of (100*b1)% in Y
gen ltestscr=log(testscr)
reg ltestscr avginc 
eststo reg_loglin
esttab reg_a reg_loglin, mtitles("Linear" "Log-lin" ) r2 note("LogLin: a 1% change in avginc is associated with a change of 28% in scores")

/* Note that in order to plot the fitted values we need the fitted values not to be in logs. 
Recall that E(y|x)=E(exp(beta_0+beta_1*x+u)|x)=
=exp(beta_0+beta_1*x)*E(exp(u)). 
We need an estimate for E(exp(u)) ! */
predict u_loglin, resid
scatter u_loglin avginc
gen eu_loglin=exp(u_loglin) // What are we doing here?
quietly summarize eu_loglin // What are we doing here?
scalar eu_mean_loglin=r(mean)
gen y_loglin=exp(_b[_cons]+_b[avginc]*avginc)*eu_mean_loglin
label variable y_loglin "y_loglin"
scatter testscr y_linear y_loglin  avginc, sort connect(i l l l) ///
 symbol(c i i i)

 
// R2: Why we cannot compare linear vs log model?

scatter testscr ltestscr  avginc, sort 

scatter ltestscr  avginc, sort 

scatter testscr   avginc, sort 

sum testscr ltestscr


 
 // Part 2: Dummy variables 
 
// Simulate and estimate models in which:
 
 *A) The effect of X1 on Y is constant


 *B)  The effect of X1 on Y is lower when X2 is higher (X2 must be a binary variable)

 
*C) The effect of X1 on Y depends on the value of X1 and on the value of X2


 
 *D) For models B and C, see what happens to your regression results if you omit some of this non-linear effects

 
 
 *E) Can you think of "real life" examples of these different models? (think in your own project)

 