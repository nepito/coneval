#!/usr/bin/env python3
# Código para generar mapa de México coloreado con valores aleatorios, por el momento.
# La idea es asignarle valores acorde a alguna variable obtenida de datos del INEGI.
# Los archivos pa'crear el mapita los saque del repo: https://github.com/jschleuss/mexican-states.

import geopandas as gpd
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

mex = gpd.read_file("mexican-states.shp") # Archivo shape
mex["name"] = mex["name"].str.upper() # Escribiendo en mayusculas todos los estados, para que coincida con el csv del nepo.
mex = mex.sort_values("name") # Acomodando los estados en orden alfabetico y por tanto cambiando el acomodo de todo el dataframe

variable_color = np.random.uniform(1, 10, 32) # array con 32 valores que corresponden a los edos.
fig, ax = plt.subplots(1, 1)
mex["Indice inventado"] = variable_color

mex.plot(column = "Indice inventado", cmap = "OrRd", ax = ax, legend = True,
         legend_kwds={'label': "Indice inventado", 'orientation': "vertical"})
plt.show()
