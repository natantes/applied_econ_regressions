// Q1
clear all
use "C:\Users\natan\Downloads\lead_mortality.dta"

generate leadxph = lead * ph

reg infrate lead ph leadxph, r
eststo OLS1

esttab OLS1, mtitles("m1") cells(b(star fmt(3)) se(par fmt(2))) legend label varlabels(_cons Constant) stats(r2)

sum ph

display "Average pH of the sample: " 7.322674 
display "Estimated effect of lead: " _b[lead] * 1 + _b[leadxph] * 7.322674
display "The standard deviation of pH: " .6917288 
display "Estimated effect one SD lower: " _b[lead] * 1 + _b[leadxph] * (7.322674  - 0.6917288)
display "Estimated effect one SD higher: "_b[lead] * 1 + _b[leadxph] * (7.322674  + 0.6917288)
lincom _b[lead] * 1 + _b[leadxph] * (6.5)

display .025065 ,1

reg infrate lead ph typhoid_rate np_tub_rate age, r
reg infrate lead ph leadxph, r
predict predicted
predict predicted_se, stdp

twoway (lfit predicted ph if (lead == 0), mcolor(blue)) (lfit predicted ph if (lead == 1), mcolor(red))


// Q2
clear all
use "C:\Users\natan\Downloads\CPS2015.dta", clear

reg ahe age female bachelor, r

display _b[age]



generate lnahe = ln(ahe)

reg lnahe age female bachelor, r
eststo OLS1

display 100 * (exp(_b[age]) - 1) 



generate lnage = ln(age)

reg lnahe lnage female bachelor, r
eststo OLS2

display _b[lnage]



generate age2 = age * age
reg lnahe age age2 female bachelor, r
eststo OLS3

display (((exp(_b[age]*26)) * (exp(_b[age2])*26)) - ((exp(_b[age]*25)) * (exp(_b[age2])*25))) / ((exp(_b[age]*25)) * (exp(_b[age2])*25))
display ((exp(_b[age]*34)) * (exp(_b[age2])*34)) / ((exp(_b[age]*33)) * (exp(_b[age2])*33))


esttab OLS1 OLS2 OLS3, onecell mtitles("m1" "m2" "m3") cells(b(star fmt(3)) se(par fmt(2))) legend label varlabels(_cons Constant) stats(r2)


reg lnahe age female bachelor, r
predict predicted
generate raw_predicted = exp(predicted)
generate residuals_1 = ahe - raw_predicted
scatter residuals_1 age

reg lnahe lnage female bachelor, r
predict predicted_2
generate raw_predicted_2 = exp(predicted_2)
generate residuals_2 = ahe - raw_predicted_2
scatter residuals_2 age


reg lnahe age age2 female bachelor, r
predict predicted_3
generate raw_predicted_3 = exp(predicted_3)
generate residuals_3 = ahe - raw_predicted_3
scatter residuals_3 age


twoway (qfit raw_predicted age if (female == 0 & bachelor == 0), mcolor(blue)) (qfit raw_predicted_2 age if (female == 0 & bachelor == 0), mcolor(red)) (qfit raw_predicted_3 age if (female == 0 & bachelor == 0), mcolor(green)) || (qfit raw_predicted age if (female == 1 & bachelor == 1), mcolor(blue)) (qfit raw_predicted_2 age if (female == 1 & bachelor == 1), mcolor(red)) (qfit raw_predicted_3 age if (female == 1 & bachelor == 1), mcolor(green))

generate femalexbachelor = female * bachelor

reg lnahe age age2 female bachelor femalexbachelor, r
scalar alexis = _b[age] * 30 + _b[age2] * (30 * 30) + _b[female] + _b[bachelor] + _b[femalexbachelor] + _b[_cons]
scalar alexis = exp(alexis)
display "Alexis: " alexis
scalar jane = _b[age] * 30 + _b[age2] * (30 * 30) + _b[female] + _b[_cons]
scalar jane = exp(jane)
display "Jane: " jane
display "Difference between Alexis and Jane: " alexis - jane

scalar alexis = _b[age] * 30 + _b[age2] * (30 * 30) + _b[female] + _b[bachelor] + _b[femalexbachelor] + _b[_cons]
scalar alexis = exp(alexis)
scalar jane = _b[age] * 30 + _b[age2] * (30 * 30) + _b[female] + _b[_cons]
scalar jane = exp(jane)
scalar Bob = _b[age] * 30 + _b[age2] * (30 * 30) + _b[bachelor] + _b[_cons]
scalar Bob = exp(Bob)
scalar Jim = _b[age] * 30 + _b[age2] * (30 * 30) + _b[_cons]
scalar Jim = exp(Jim)

display "Alexis: " alexis
display "Jane: " jane
display "Difference between Alexis and Jane: " alexis - jane
display "Bob: " Bob
display "Jim: " Jim
display "Difference between Bob and Jim: " Bob - Jim

// Q3
clear all
use "C:\Users\natan\Downloads\gpa2.dta", clear

generate hsize_sq = hsize * hsize

reg sat hsize hsize_sq, r
eststo OLS1

generate lnsat = ln(sat)

reg lnsat hsize hsize_sq, r
eststo OLS2

esttab OLS1 OLS2, onecell mtitles("m1" "m2") cells(b(star fmt(3)) se(par fmt(2))) legend label varlabels(_cons Constant) stats(r2)
