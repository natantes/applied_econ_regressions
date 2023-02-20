// uncomment below to install required package
// search eststo
// ssc install estout, replace

// Q1
use "C:\Users\natan\Downloads\Bwght.dta"
scatter bwght cigs

reg bwght cigs faminc fatheduc motheduc male white, r
eststo OLS1

estout OLS1, title("m1") cells(b(star fmt(3)) se(par fmt(2)) t) legend label varlabels(_cons Constant) stats(r2)

display "Two additional cigarettes per day: " _b[cigs] * 2

display "One pack per day: " _b[cigs] * 20


// Q2
clear all
use "C:\Users\natan\Downloads\Vote.dta"

reg voteA expendA expendB prtystrA, r

eststo OLS1

estout OLS1, title("m1") cells(b(star fmt(3)) se(par fmt(2))) legend label varlabels(_cons Constant) stats(r2)

display "When both candidates spend 1000: " _b[expendA] * 1 + _b[expendB] * 1

// Q3
clear all
use "C:\Dev\applied_econ_regressions\datasets\Baseball.dta"

reg salary years gamesyr bavg hrunsyr rbisyr sbasesyr, r
eststo OLS1

reg salary years gamesyr bavg hrunsyr sbasesyr, r
eststo OLS2

reg salary bavg, r
eststo OLS3

esttab  OLS1 OLS2 OLS3, mtitles("m1" "m2" "m3") ///
	using "C:\Dev\applied_econ_regressions\datasets\table1.tex", ///
	cells(b(star fmt(3)) se(par fmt(2)) t) legend label varlabels(_cons Constant) stats(r2) 

