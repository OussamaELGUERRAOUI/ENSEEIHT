# -*- coding: utf-8 -*-
"""
Created on Mon Jan  8 01:52:23 2024

@author: elgue
"""

import networkx as nx
import matplotlib.pyplot as plt
import random

# Création du graphe
G = nx.Graph()

# Ajout de 10 nœuds représentant les satellites
num_satellites = 10
for i in range(num_satellites):
    G.add_node(i, pos=(random.uniform(0, 10), random.uniform(0, 10)))

# Ajout d'arêtes si la distance est inférieure à 10 km
for i in range(num_satellites):
    for j in range(i + 1, num_satellites):
        pos_i = G.nodes[i]['pos']
        pos_j = G.nodes[j]['pos']
        distance = ((pos_i[0] - pos_j[0])**2 + (pos_i[1] - pos_j[1])**2)**0.5
        if distance < 3:
            G.add_edge(i, j)

# Extraction des positions des nœuds pour l'affichage
node_positions = nx.get_node_attributes(G, 'pos')
print(node_positions)

# Affichage du graphe
nx.draw(G, pos=node_positions, with_labels=True, font_weight='bold', node_size=700, node_color='skyblue', font_color='black')
plt.title('Graphe des Satellites')
plt.show()



def calculer_caracteristiques(graphe):
    # Degré moyen
    degre_moyen = nx.average_degree_connectivity(graphe)

    # Distribution du degré
    distribution_degre = dict(graphe.degree())

    # Moyenne du degré de clustering
    clustering_moyen = nx.average_clustering(graphe)

    # Nombre de cliques et leurs ordres
    cliques = list(nx.find_cliques(graphe))
    nombre_cliques = len(cliques)
    ordres_cliques = [len(clique) for clique in cliques]

    # Nombre de composantes connexes et leurs ordres
    composantes_connexes = nx.connected_components(graphe)
    nombre_composantes_connexes = nx.number_connected_components(graphe)
    ordres_composantes_connexes = [len(comp) for comp in composantes_connexes]

    # Longueur des chemins les plus courts, distribution des plus courts chemins
    # et nombre des plus courts chemins
    longueur_chemins = nx.all_pairs_shortest_path_length(graphe)
    #distribution_chemins = [length for _, lengths in longueur_chemins.items() for length in lengths.values()]
    #nombre_chemins = len(distribution_chemins)

    return {
        "degre_moyen": degre_moyen,
        "distribution_degre": distribution_degre,
        "clustering_moyen": clustering_moyen,
        "nombre_cliques": nombre_cliques,
        "ordres_cliques": ordres_cliques,
        "nombre_composantes_connexes": nombre_composantes_connexes,
        "ordres_composantes_connexes": ordres_composantes_connexes,
        #"distribution_chemins": distribution_chemins,
        #"nombre_chemins": nombre_chemins
    }

# Exemple d'utilisation avec un graphe non valué (à remplacer par votre propre graphe)
# Ici, nous utilisons un graphe en forme de cercle pour l'exemple


# Calcul des caractéristiques
resultats = calculer_caracteristiques(G)

# Affichage des résultats
print("Degré moyen:", resultats["degre_moyen"])
print("Distribution du degré:", resultats["distribution_degre"])
print("Moyenne du degré de clustering:", resultats["clustering_moyen"])
print("Nombre de cliques:", resultats["nombre_cliques"])
print("Ordres des cliques:", resultats["ordres_cliques"])
print("Nombre de composantes connexes:", resultats["nombre_composantes_connexes"])
print("Ordres des composantes connexes:", resultats["ordres_composantes_connexes"])
#print("Distribution des plus courts chemins:", resultats["distribution_chemins"])
#print("Nombre des plus courts chemins:", resultats["nombre_chemins"])
