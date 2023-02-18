

// QUESTION 1
clear all
// use "C:\Users\natan\Downloads\cps04.dta", clear
use "/Users/natan/Dev/applied_econ_regressions/datasets/cps04.dta", clear

// (1A)
gen lnahe = ln(ahe)
gen lnage = ln(age)
gen age2 = age * age

eststo OLS1: reg ahe age female bachelor, r
rvpplot age
ovtest

eststo OLS2: reg lnahe age female bachelor, r
rvpplot age
ovtest

eststo OLS3: reg lnahe lnage female bachelor, r
rvpplot lnage
ovtest

eststo OLS4: reg lnahe age age2 female bachelor, r
rvpplot age
ovtest

esttab OLS1 OLS2 OLS3 OLS4, onecell mtitles("m1" "m2" "m3" "m4") cells(b(star fmt(3)) se(par fmt(2))) legend label varlabels(_cons Constant) stats(r2)


// (1B)
reg ahe age female bachelor, r
// For Model 1 the amount would be the same both 25 -> 26 and 33 -> 34 which is:
display _b[age]

reg lnahe age female bachelor, r
// For Model 2 the amount would be the following:
display exp(_b[age] * 26 + _b[female] + _b[bachelor] + _b[_cons]) - exp(_b[age] * 25 + _b[female] + _b[bachelor] + _b[_cons])
display exp(_b[age] * 34 + _b[female] + _b[bachelor] + _b[_cons]) - exp(_b[age] * 33 + _b[female] + _b[bachelor] + _b[_cons])

reg lnahe lnage female bachelor, r
// For Model 3, the amount that would change would be the following:
display exp(_b[lnage] * ln(26) + _b[female] + _b[bachelor] + _b[_cons]) - exp(_b[lnage] * ln(25) + _b[female] + _b[bachelor] + _b[_cons])
display exp(_b[lnage] * ln(34) + _b[female] + _b[bachelor] + _b[_cons]) - exp(_b[lnage] * ln(33) + _b[female] + _b[bachelor] + _b[_cons])

reg lnahe age age2 female bachelor, r
// For Model 4, the amount that would change would be the following:
display exp(_b[age] * 26 + _b[age2] * 26 * 26 + _b[female] + _b[bachelor] + _b[_cons]) - exp(_b[age] * 25 + _b[age2] * 25 * 25 + _b[female] + _b[bachelor] + _b[_cons])
display exp(_b[age] * 34 + _b[age2] * 34 * 34 + _b[female] + _b[bachelor] + _b[_cons]) - exp(_b[age] * 33 + _b[age2] * 33 * 33 + _b[female] + _b[bachelor] + _b[_cons])

// (1C)
// Generally, according to the resiudal plots, and shape of the data, the 
// quadratic model seems to fit the diminishing nature of the data better when 
// compared to the other models. 

// (1D)
// Yes, since the dummy coefficent on female is not small and is significant,
// it would suggest that there exists a difference between the reference group
// which is males and the dummy group which is females. Since the coefficent is
// negative, females generally make fixed percentage less based on semi log model


// (1E)
gen femalexage = female * age

eststo OLS1: reg lnahe age age2 female bachelor femalexage, r
rvpplot age
ovtest

eststo OLS2: reg lnahe age age2 female bachelor femalexage lnage, r
rvpplot age
ovtest

esttab OLS1 OLS2 OLS4, onecell mtitles("m1" "m2" "m3") cells(b(star fmt(3)) se(par fmt(2))) legend label varlabels(_cons Constant) stats(r2)
// The preference between the two models in part (E) is the model that exludes
// the lnage variable, the inclusion of the regressors seems to create the 
// problem that both variables capture the diminishing return nature of the
// of the data generating process so the minimizing problem of OLS cannot
// differntiate between the explantory power of over the other. Compared to the 
// best model for model C which was the quadratic model, this model includes a
// relevant interaction term which helps better explain the relationship.

// (1F)
// Yes but this model gives a more nuanced version of the difference. The model
// suggests, based on the coefficent of female, that there does not exist a
// significant *fixed* difference between females and males, but there exists
// a difference between females with males as they become older due to the 
// sigificant coefficent on the femalexage term.

// (1G)
// The predicted earnings males and females differ by 0.0098328% where females
// make 0.0098328% less per year.

// (1H)
gen bachelorxfemale = female * bachelor
gen bachelorxfemalexage = female * bachelor * age
reg lnahe age age2 female bachelor femalexage bachelorxfemale bachelorxfemalexage lnage, r
test bachelorxfemalexage bachelorxfemale 
// The hypothesis can be tested by introducing interaction terms. The
// results suggest that there does exist a significant difference between 
// females with bachelor degrees and males with bachelor degreees.

// QUESTION 2
// use "/Users/natan/applied_econ_regressions/TeachingRatings.dta", clear

eststo OLS1: reg course_eval age minority female onecredit beauty intro nnenglish, r

eststo OLS2: reg course_eval minority female onecredit beauty nnenglish, r

rvpplot beauty
ovtest

esttab OLS1 OLS2, onecell mtitles("m1" "m2") cells(b(star fmt(3)) se(par fmt(2))) legend label varlabels(_cons Constant) stats(r2)


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







