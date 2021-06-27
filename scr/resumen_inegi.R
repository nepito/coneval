library("coneval")
library("tidyverse")
library("ggplot2")


data <- readr::read_csv("data/raw/tabla2_3_basicos_inegi.csv", col_types = "fdf")
ingreso_estado <- coneval::summarize_income_by_state(data)
ingreso_estado$promedio <- round(ingreso_estado$promedio)
write_csv(ingreso_estado, "reports/ingreso_estado.csv")
ingreso_decil <- coneval::summarize_income_by_decil(data)
ingreso_decil$promedio <- round(ingreso_decil$promedio)
write_csv(ingreso_decil, "reports/ingreso_decil.csv")
gini_nacional <- coneval::calculate_gini_all_states(data)
gini_nacional$gini <- round(gini_nacional$gini * 100)
write_csv(gini_nacional, "reports/gini_nacional.csv")

marcas_eje_y <- pretty(c(min(0), max(data$ingreso)))
ggplot(data, aes(x = decil, y = ingreso)) + 
    geom_boxplot() +
    geom_jitter(shape=16, position=position_jitter(0.2)) +
    theme_classic() +
    scale_y_continuous(
        expand = c(0,0),
        limits = range(marcas_eje_y),
        breaks = marcas_eje_y,
        labels = scales::dollar
    )
ggsave("reports/boxplot_deciles.png")