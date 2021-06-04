library(ineq)
library(tidyverse)

gini_by_state <- function(data, state){
    gini <-  data %>% 
        dplyr::filter(entidad_federativa == state) %>% 
        .$ingreso %>% 
        ineq::ineq(type="Gini")
}

# Función que calcula el índice de Gini para cada estado
calculate_gini_all_states <- function(data){
    gini_all_state <- data %>%
        dplyr::group_by(entidad_federativa) %>%
        dplyr::summarize(gini = ineq::ineq(ingreso, type="Gini"))
}
# Función que agrupa los datos del índice de gini para cada estado por decil
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
