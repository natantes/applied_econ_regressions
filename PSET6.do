clear all
// use "C:\Users\natan\Downloads\cps04.dta"
// use "/Users/natan/applied_econ_regressions/cps04.dta"

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
display exp(_b[age] * 26 - _b[age] * 25)
display exp(_b[age] * 36 - _b[age] * 35)
reg lnahe lnage female bachelor, r
// For Model 3, the amount that would change would be the following:
reg lnahe age age2 female bachelor, r
// For Model 4, the amount that would change would be the following:

// (1C)

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





