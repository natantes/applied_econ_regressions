clear all
use "C:\Users\natan\Downloads\guns.dta", clear

generate lnvio = ln(vio)

// QUESTION 1

// 1(a)
reg lnvio shall, r
display 100 * (exp(_b[shall]) - 1)
reg lnvio shall incarc_rate density avginc pop pb1064 pw1064 pm1029, r
display 100 * (exp(_b[shall]) - 1)

// 1(ai)
// if the state has a shall issue law in effect, violent crime per year will decrease by 100 * (exp(_b[shall]) - 1)
// The estimate is large in the real world sense since changes in percentages of over < 1% are already relatievly
// large in most cases

// 1(aii)
// The t-statatic of shall actually becomes more significant after the accounting for all the control variables
// the real world significance or the raw value of the variable decreases however. Yet, the value itself, in the
// real world sense, it still relatievly large with an estimate of -30% as compared to -36%

// 1(aiii)
// Different states likely have different rates of crime more generally due to state factors like
// law structure, police funding, population charachteristics, and other similar factors. In order
// to account for these unobserved heterogenities we need state fixed effects through dummy variables
// or simply incorporating the state fixed effects into the regression

// 1(b)
reg lnvio shall incarc_rate density avginc pop pb1064 pw1064 pm1029 i.stateid, absorb(stateid) r
// Yes, the results do change a relatievly significant amount after incorporating the fixed state effects.
// The regression including state fixed effects should be more credible due to the drastic heterogeneity 
// that may exist across states (in the United States)

// 1(c)
reg lnvio shall incarc_rate density avginc pop pb1064 pw1064 pm1029 i.year, absorb(year) r
// The results do change but not as signifcantly as the state fixed effects version of the regression.
// I believe the state fixed effects regression is more credible that the fixed time effects model
// because there is more heterogeneity across different states as opposed to different time periods
// but the fixed time effects version is more credible then going without state nor time fixed effects
// because this regression suggests there may still exist some heterogeneity across time.


// 1(d)
generate lnmur = ln(mur)
generate lnrob = ln(rob)
reg lnmur shall, r
reg lnmur shall incarc_rate density avginc pop pb1064 pw1064 pm1029, r
reg lnmur shall incarc_rate density avginc pop pb1064 pw1064 pm1029, absorb(stateid) r
reg lnmur shall incarc_rate density avginc pop pb1064 pw1064 pm1029, absorb(year) r

reg lnrob shall, r
reg lnrob shall incarc_rate density avginc pop pb1064 pw1064 pm1029, r
reg lnrob shall incarc_rate density avginc pop pb1064 pw1064 pm1029, absorb(stateid) r
reg lnrob shall incarc_rate density avginc pop pb1064 pw1064 pm1029, absorb(year) r

// 1(e)
reg lnvio shall incarc_rate density avginc pop pb1064 pw1064 pm1029 i.year i.stateid, absorb(year) r
// I believe the remaining threat to the validity is endongeity, it is not unreasonable to suppose that
// those states who have had lower or higher crime rate before may have had different propensities to adopt
// certain laws based on their initial conditions.

// 1(f)
// Based on the coefficient and t statatic on the shall dummy with the addition of the fixed
// state effects, it can be reasonably concluded that the hypothesis that the effect of shall
// is not significantly different from 0 at the 90% and 95% significant level cannot be rejected. 


// QUESTION 2
clear all
use "C:\Users\natan\Downloads\seatbelts.dta"
gen lnincome = ln(income) 
// 2(a)
reg fatalityrate sb_useage speed65 speed70 ba08 drinkage21 lnincome age, r
// No, the regression suggests that increased seatbelt usage leads to increased fatality rate
// since the coefficient is positive on sb_useage

// 2(b)
egen statenum = group(state)
reg fatalityrate sb_useage speed65 speed70 ba08 drinkage21 lnincome age, absorb(statenum) r
// Yes, it is likely because there were other variables that were charachteristics of the state
// that were correlated with both sb_useage and fatality rate biasing the coefficient on seatbelt usage
// upwards.

// 2(c)
reg fatalityrate sb_useage speed65 speed70 ba08 drinkage21 lnincome age i.year, absorb(statenum)  r
// The results are in line with 2(b) but the maginitude on the coefficient is a lower.

// 2(d)
// I believe that regression (c) is most credible because all states have different charachteristics
// that can effect the fatalityrate and fatalityrate more generally over time likely decreases
// due to changes in technology but (c) still shows that seatbelt usage is statistically significantly
// at the 95% significane level

// 2(e)
// Generally, the coefficient is seemingly small compared to the coefficient from question 1 in the
// real world sense, but when applied to large populations, the coefficient can be considered not small.
// The percent of lives saved would be the following:
display (_b[sb_useage]) * (0.90 - 0.52)
// In the United states, the number of lives saved would be the following:
display (_b[sb_useage]) * (0.90 - 0.52) * 300000000

// 2(f)
reg sb_useage primary secondary speed65 speed70 ba08 drinkage21 lnincome, r
// Yes, both coefficents are positive so both lead to higher seatbelt usage.

// 2(g)
reg fatalityrate sb_useage speed65 speed70 ba08 drinkage21 lnincome age i.year, absorb(statenum)  r
// The percent of lives saved would be the following:
display (_b[sb_useage]) * (0.3009 - 0.1499)

// QUESTION 3
clear all
use "C:\Users\natan\Downloads\MURDER.dta", clear
egen statenum = group(state)

// 3(a) 
// If executions have a deterrent effect, the sign of B_1 should be negative since
// an increase in executions should decrease the amount of murders occuring
// B_2, if significant, would likely be positive since the more unemployed there are
// the more people there are in the conditions that may lead to the rise of crimes
// such as murder.

// 3(b)
reg mrdrte exec unem if d90 == 1 | d93 == 1, r
// No, the regression suggests that exeuctions postievly covary with the murder rate, it
// does not seem reasonable that the causual direction is higher rates of exeuctions
// lead to higher rates of murder

// 3(c)
reg mrdrte exec unem if d90 == 1 | d93 == 1, absorb(statenum) 
// Accounting for unobserved heterogenities between states, there now suggests a 
// deterrence effect between exeuction rates and murder rate since the coefficient becomes
// negative

// 3(d)
reg mrdrte exec unem if d90 == 1 | d93 == 1, absorb(statenum) r
// Accounting for heteroskedasticity, the same result as in (c) is attained with a 
// higher level of significance since the P-value reaches P = 0.000

// 3(e) 
sort exec
// Texas has the highest execution rate, It had 23 more executions then the second highest state in 1993

// 3(f) 
reg mrdrte exec unem if (d90 == 1 | d93 == 1) & state != "TX", absorb(statenum) 
reg mrdrte exec unem if (d90 == 1 | d93 == 1) & state != "TX", absorb(statenum) r
// The coefficient is almost half of what it was with the state texas in the regression and
// the t statitic becomes so small that it is the coefficient is not longer signifcant at then
// 95% or 90% confidence level thresholds.

// 3(g)
reg mrdrte exec unem i.year, absorb(statenum) r
// The coefficient is larger than it was when only the two years were used however
// the signifiance of the t stataistic is slightly less signifcant, however it is
// still signifcant at the 90% signifcance level.


