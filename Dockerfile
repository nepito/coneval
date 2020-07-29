FROM islasgeci/base:13fe

RUN R -e "install.packages(c('tidyverse', 'testthat'), dependencies=TRUE, repos='http://cran.rstudio.com/')"
