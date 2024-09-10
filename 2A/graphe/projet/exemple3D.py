import networkx as nx
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import random

# Création du graphe
G = nx.Graph()

# Ajout de 100 nœuds représentant les satellites
num_satellites = 100
for i in range(1, num_satellites + 1):
    G.add_node(i, pos=(random.uniform(0, 10), random.uniform(0, 10), random.uniform(0, 10)))

# Ajout d'arêtes si la distance est inférieure à 10 km
for i in range(1, num_satellites + 1):
    for j in range(i + 1, num_satellites + 1):
        pos_i = G.nodes[i]['pos']
        pos_j = G.nodes[j]['pos']
        distance = ((pos_i[0] - pos_j[0])**2 + (pos_i[1] - pos_j[1])**2 + (pos_i[2] - pos_j[2])**2)**0.5
        if distance < 3:
            G.add_edge(i, j)

# Extraction des positions des nœuds pour l'affichage
node_positions = nx.get_node_attributes(G, 'pos')

# Création d'une figure en 3D
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

# Affichage du graphe en 3D
for node, pos in node_positions.items():
    x, y, z = pos
    ax.scatter(x, y, z, label=str(node), s=50)
    ax.text(x, y, z, str(node), fontsize=8, color='black')  # Ajout du texte à chaque nœud

for edge in G.edges():
    pos_start = node_positions[edge[0]]
    pos_end = node_positions[edge[1]]
    x_values = [pos_start[0], pos_end[0]]
    y_values = [pos_start[1], pos_end[1]]
    z_values = [pos_start[2], pos_end[2]]
    ax.plot(x_values, y_values, z_values, color='gray')

# Affichage de la figure
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')
plt.title('Graphe des Satellites en 3D')
plt.legend()
plt.show()
