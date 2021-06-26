#!/usr/bin/env python3
# Código para generar mapa de México coloreado con valores aleatorios, por el momento.
# La idea es asignarle valores acorde a alguna variable obtenida de datos del INEGI.
# Los archivos pa'crear el mapita los saque del repo: https://github.com/jschleuss/mexican-states.

import geopandas as gpd
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

mex = gpd.read_file("data/shapefile/mexican-states.shp") # Archivo shape
mex["name"] = mex["name"].str.upper() # Escribiendo en mayusculas todos los estados, para que coincida con el csv del nepo.
mex = mex.sort_values("name") # Acomodando los estados en orden alfabetico y por tanto cambiando el acomodo de todo el dataframe

#variable_color = np.random.uniform(1, 10, 32) # array con 32 valores que corresponden a los edos.

archivo = pd.read_csv("data/raw/tabla2_3_basicos_inegi.csv") # Abrir archivo.csv que rolo el nepo.
gini_decil = archivo.loc[((archivo["decil"] == "I ") & (archivo["entidad_federativa"] != "NACIONAL"))] #Escoger sólo decil I sin incluir NACIONAL
gini_decil.index = np.arange(0, 32)  # Reescribir los indices a la brava para poder incluirlo en el dataframe mex
mex["ingreso"] = gini_decil["ingreso"] # Incluyendo los valores de ingreso al dataframe con el shapefile
fig, ax = plt.subplots()
#mex["Indice inventado"] = variable_color

mex.plot(column = "ingreso", cmap = "OrRd", ax = ax, legend = True,
         legend_kwds={'label': "Coef. Gini", 'orientation': "vertical"})
plt.savefig("mapa.png")
