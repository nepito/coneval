FROM islasgeci/jupyter:5869

RUN R -e "install.packages(c('covr', 'devtools', 'ineq', 'lintr', 'testthat', 'tidyverse'), dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "devtools::install_github('klutometis/roxygen', upgrade = FALSE)"