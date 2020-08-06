#!/usr/bin/env Rscript
#
# 

library('devtools')
library('roxygen2')

package.skeleton("coneval")

my_rpackages <- as.package("coneval")
load_all(my_rpackages)
document(my_rpackages)