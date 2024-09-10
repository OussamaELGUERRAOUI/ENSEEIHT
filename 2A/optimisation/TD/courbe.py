# -*- coding: utf-8 -*-
"""
Created on Wed Sep 27 02:53:17 2023

@author: elgue
"""

import numpy as np
import matplotlib.pyplot as plt

# Paramètres
b = 2.0

# Fonction objectif
def f(x1, x2):
    return (1/2) * ((x1 - 1)**2 + x2**2)

# Contrainte
def h(x1, x2):
    return -x1 + b * x2**2

# Création de la grille pour le graphique
x1 = np.linspace(-3, 3, 400)
x2 = np.linspace(-3, 3, 400)
X1, X2 = np.meshgrid(x1, x2)
Z = f(X1, X2)

# Tracé des lignes de niveau de la fonction objectif
plt.contour(X1, X2, Z, levels=20)

# Tracé de la contrainte h(x) = 0
plt.contour(X1, X2, h(X1, X2), levels=[0], colors='r')

plt.xlabel('x1')
plt.ylabel('x2')
plt.title('Représentation graphique de la contrainte et des lignes de niveau')
plt.grid(True)
plt.show()
