FROM islasgeci/base:feef
COPY . /workdir
WORKDIR /workdir
RUN R -e "install.packages(c('covr', 'devtools', 'ineq', 'lintr', 'testthat', 'tidyverse'), dependencies=TRUE, repos='http://cran.rstudio.com/')"
RUN R -e "devtools::install_github('klutometis/roxygen', upgrade = FALSE)"
RUN R CMD build coneval
RUN R CMD INSTALL coneval_1.0.tar.gz
RUN pip install geopandas