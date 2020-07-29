FROM islasgeci/jupyter:5869

RUN R -e "install.packages(c('tidyverse', 'testthat'), dependencies=TRUE, repos='http://cran.rstudio.com/')"
