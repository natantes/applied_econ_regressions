clear all
use "C:\Users\natan\Downloads\cps04.dta"

gen lnahe = ln(ahe)
gen lnage = ln(age)
gen age2 = age * age

reg ahe age female bachelor
rvpplot age

reg lnahe age female bachelor
rvpplot age

reg lnahe lnage female bachelor
rvpplot lnage

reg lnahe age age2 female bachelor
rvpplot age