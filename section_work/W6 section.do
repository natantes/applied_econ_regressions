 
************************************************
*	  Part a: 	Doing montecarlo simulations 	   *
************************************************
 
clear all
program simple
        syntax [, obs(integer 1) ]
        drop _all
        set obs `obs'
        generate z = runiform(-1,1)  
		generate x = rnormal(0,1) 
		sum z
		scalar mean_z = r(mean)
		sum x 
		scalar mean_x = r(mean)
end
	
	
simulate mean_z=mean_z mean_x=mean_x, reps(10): simple, obs(1000)

twoway (histogram mean_z , color(red%30)) ///        
       (histogram mean_x , color(green%30)), ///   
       legend(order(1 "mean z" 2 "mean x" ))

simulate mean_z=mean_z mean_x=mean_x, reps(100): simple, obs(1000)
twoway (histogram mean_z , color(red%30)) ///        
       (histogram mean_x , color(green%30)), ///   
       legend(order(1 "mean z" 2 "mean x" ))

simulate mean_z=mean_z mean_x=mean_x, reps(1000): simple, obs(1000)
twoway (histogram mean_z , color(red%30)) ///        
       (histogram mean_x , color(green%30)), ///   
       legend(order(1 "mean z" 2 "mean x" ))


************************************************
*	  Part b: 	IV in stata	            	   *
************************************************

clear all
set obs 500 /* "Big" sample size, so asymptotic normality makes sense */

generate Z = runiform(0,2)  // our instrument
generate x2 = rnormal(1,1) // Is going to be the Ommited variable 
generate x1 = rnormal(2,1) + Z^2 + 0.5*x2  // as independent variable
generate u = rnormal(0,5) /* We generate errors which satisfy E(u|x1,x2)=0 */
generate y = 10 + 5*x1 + 3*x2 + u /* We generate the dependent variable */

* Check assumptions (in applications we don't observe u')

generate e = 3*x2 + u // This is the unobservable for us

corr x1 e // X1 is endogenous
corr x1 Z //Instrument is relevant
corr e Z // Instrument is valid


* Suppose we observe everything
eststo base: reg y x1 x2, robust
esttab base, ci r2 mtitles("Baseline")


* What if we make standard ols, without observing x2 *
eststo OLS: reg y x1, robust
esttab base OLS, ci r2 mtitles("Baseline" "OLS")
* Note: Positive Bias, as we expect

* Can we control the problem by include Z as a control??
eststo control: reg y x1 Z, robust
esttab OLS control, ci mtitles("OLS" "Control")

******* Two steps least squares by hand *********

* First stage *
reg x1 Z
predict x1_hat

* Second Stage
eststo IV1: reg y x1_hat


********* Stata 2SLS ****************
eststo IV2: ivregress 2sls y (x1 =Z)


* Do you observe any difference between IV1 and IV2? why? which is correct
esttab OLS IV1 IV2, ci r2 mtitles("OLS" "IV1" "IV2")


********************************************************
*	  Part c: 	Week Instruments	            	   *
********************************************************

/*

Instructions:

- Construct a DGP (Y=b0 + b1 X + U) in which you have endegeneity.
Construct two instruments. One "weak" (Z1) (low corr between X and Z) and one strong (Z2)
- Take a random draw of the DGP of size 1000. Estimate b1 by OLS; estimate b1 by 2SLS using Z1 as instruments; and 
estimate b1 by 2SLS using Z2 as instruments. Store your estimates
- Repeat times this procedure 100 times (if you can do it fast, repeat it 1000 times)
- Use an histogram to plot the distribution of b1 under each of these methods.
*/

clear all

program simple
        syntax [, obs(integer 1) ]
        drop _all
        set obs `obs'
		generate Z1 = runiform(0,2)  // our instrument
		generate Z2 = runiform(0,4)
		generate x2 = rnormal(1,1) // Is going to be the Ommited variable 
		generate x1 = rnormal(2,1) + Z1^2 + Z2*0.005 + 0.5*x2  // as independent variable
		generate u = rnormal(0,5) /* We generate errors which satisfy E(u|x1,x2)=0 */
		generate y = 10 + 5*x1 + 3*x2 + u /* We generate the dependent variable */

		* Check assumptions (in applications we don't observe u')

		generate e = 3*x2 + u // This is the unobservable for us

		corr x1 e // X1 is endogenous
		corr x1 Z1 // Strong
		corr x1 Z2 // Weak
		corr e Z1 
		corr e Z2 
		
		eststo IV2: ivregress 2sls y (x1 =Z1)
		scalar weak_iv = _b[x1]
		eststo IV2: ivregress 2sls y (x1 =Z2)
		scalar strong_iv = _b[x1]
end

simulate weak_iv=weak_iv strong_iv=strong_iv, reps(1000): simple, obs(100)

twoway (histogram weak_iv if weak_iv > -10 & weak_iv < 10, color(red%30)) ///        
       (histogram strong_iv if strong_iv > -10 & strong_iv < 10, color(green%30)), ///   
       legend(order(1 "strong_iv" 2 "weak_iv" ))

