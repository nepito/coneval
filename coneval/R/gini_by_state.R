library(ineq)
library(tidyverse)

gini_by_state <- function(data, state){
    gini <-  data %>% 
        dplyr::filter(entidad_federativa == state) %>% 
        .$ingreso %>% 
        ineq::ineq(type="Gini")
}