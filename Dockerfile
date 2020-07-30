FROM islasgeci/jupyter:5869

RUN R -e "install.packages(c('covr', 'ineq', 'lintr', 'roxygen2', 'testthat', 'tidyverse'), dependencies=TRUE, repos='http://cran.rstudio.com/')"
