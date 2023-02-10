clear all
// use "C:\Users\natan\Downloads\cps04.dta"
use "/Users/natan/applied_econ_regressions/cps04.dta"

gen lnahe = ln(ahe)
gen lnage = ln(age)
gen age2 = age * age

reg ahe age female bachelor, r
rvpplot age
ovtest

reg lnahe age female bachelor, r
rvpplot age
ovtest

reg lnahe lnage female bachelor, r
rvpplot lnage
ovtest

reg lnahe age age2 female bachelor, r
rvpplot age
ovtest


// (1B)
reg ahe age female bachelor, r
// For Model 1 the amount would be the same both 25 -> 26 and 33 -> 34 which is:
display _b[age]

reg lnahe age female bachelor, r
// For Model 2 the amount would be the following:
display exp(_b[age] * 26 + _b[female] + _b[bachelor]) - exp(_b[age] * 25 + _b[female] + _b[bachelor])
display exp(_b[age] * 34 + _b[female] + _b[bachelor]) - exp(_b[age] * 33 + _b[female] + _b[bachelor])
display exp(_b[age] * 26) - exp(_b[age] * 25)
display exp(_b[age] * 34) - exp(_b[age] * 33)

reg lnahe lnage female bachelor, r
// For Model 3, the amount that would change would be the following:
display exp(_b[lnage] * ln(26) + _b[female] + _b[bachelor]) - exp(_b[lnage] * ln(25) + _b[female] + _b[bachelor])
display exp(_b[lnage] * ln(34) + _b[female] + _b[bachelor]) - exp(_b[lnage] * ln(33) + _b[female] + _b[bachelor])

reg lnahe age age2 female bachelor, r
// For Model 4, the amount that would change would be the following:
display exp(_b[age] * 26 + _b[age2] * 26 * 26 + _b[female] + _b[bachelor]) - exp(_b[age] * 25 + _b[age2] * 25 * 25 + _b[female] + _b[bachelor])
display exp(_b[age] * 34 + _b[age2] * 34 * 34 + _b[female] + _b[bachelor]) - exp(_b[age] * 33 + _b[age2] * 33 * 33 + _b[female] + _b[bachelor])

// (1C)
// Generally, according to the resiudal plots, and shape of the data, the 
// quadratic model seems to fit the diminishing nature of the data better when 
// compared to the other models. 

// (1D)
// Yes, since the dummy coefficent on female is not small and significant,
// it would suggest that there exists a difference between the reference group
// which is males and the dummy group which is females.


// (1E)
gen femalexage = female * age

reg lnahe age age2 female bachelor femalexage, r
rvpplot age
ovtest

reg lnahe age age2 female bachelor femalexage lnage, r
rvpplot age
ovtest

// (1F)
// Yes but this model gives a more nuanced version of the difference. The model
// suggests, based on the coefficent of female, that there does not exist a
// significant *fixed* difference between females and males, but there exists
// a difference between females with males as they become older due to the 
// sigificant coefficent on the femalexage term.

// (1G)
// The predicted earnings males and females differ by 0.0098328% where females
// make that much less per year.

// (1H)
gen bachelorxfemale = female * bachelor
gen bachelorxfemalexage = female * bachelor * age
reg lnahe age age2 female bachelor femalexage bachelorxfemale bachelorxfemalexage lnage, r
test bachelorxfemalexage bachelorxfemale 
// The hypothesis can be tested by introducing interaction terms. The
// results suggest that there does exist a significant difference between 
// females with bachelor degrees and males with bachelor degreees.

// use "/Users/natan/applied_econ_regressions/TeachingRatings.dta", clear

reg course_eval age minority female onecredit beauty intro nnenglish, r
reg course_eval minority female onecredit beauty nnenglish, r
rvpplot beauty
ovtest

// (2)
// Since the amount of observations are much larger than the amount of potential
// regressors, I first ran a regression including all variables. From this first
// model, it seems as though age and intro classes are not releveant explantory 
// variables so the joint probability was tested using the "test" command.
// Since the F statistic still gets rejected at the so the model was reduced to
// a version without the two irrelavant variables to get more accurate errors
// and coefficents. To attain test for omitted variables, the RESET test is done
// which gave a result that suggests the lack of omitted variables. Based on 
// this, the model would suggest that higher physical appearance is a predictor
// of higher course evaluations. If one were to give advice simply based on this
// model, if the school's objective is just to increase course evaluations, then
// it would be advisable to hire those with higher physical appearance.







