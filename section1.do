clear all
set more off

cd ""

cap log close
log using section1.log, replace

*** Input Data ***

use enrollment.dta, clear 

*** Manipulating the Data ***

gen ltuition = log(tuition) /* Generate log tuition */

drop if tuition == . /* Drop missing variables */

drop ltuition /* Drop log tuition */

gen tuition2500 = 0 /* Generate variable for tutition being greater than $2500, intially set at 0 */
replace tuition2500 = 1 if tuition > 2500 /* Replace with 1 if tuition is greater than $2500 */

rename tuition2500 expensive /* Rename variable to expensive */

*** Descriptive Statistics ***

sum enrollment tuition /* Find descriptive statistics */

sum enrollment tuition, detail /* Find more detailed descriptive statistics */

tab region /* Find frequency of categorical data */

tabstat enrollment, by(region) stat(co me sd p25 med p75 r) /* Find descriptive statistics by category */

*** Data Analysis ***

reg enrollment tuition /* regress enrollment on tuition */

twoway (scatter enrollment tuition) (lfit enrollment tuition) /* Graph a scatter plot, with a fitted line */

predict predicted_enrollment /* create new variable with predicted enrollement from regression */

twoway (scatter predicted_enrollment tuition) (lfit enrollment tuition) /* Graph checking all fitted values lie on fitted line*/

gen regression_residuals = enrollment - predicted_enrollment /* generate residuals */

twoway (scatter regression_residuals tuition) (lfit regression_residuals tuition) /* Graph a scatter plot, with a fitted line */

log close