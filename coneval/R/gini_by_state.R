library(ineq)
library(tidyverse)

gini_by_state <- function(data, state){
    gini <-  data %>% 
        dplyr::filter(entidad_federativa == state) %>% 
        .$ingreso %>% 
        ineq::ineq(type="Gini")
}


calculate_gini_all_states <- function(data){
    gini_all_state <- rep( 0, len=33)
}

summarize_income_by_decil <- function(data){
    summary_by <- data %>% 
        dplyr::group_by(decil) %>%
        dplyr::summarize(promedio = mean(ingreso))
}

summarize_income_by_state <- function(data){
    summary <- data %>% 
        dplyr::group_by(entidad_federativa) %>%
        dplyr::summarize(promedio = mean(ingreso))
}