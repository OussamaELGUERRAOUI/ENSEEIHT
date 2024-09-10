import networkx as nx
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import random
import numpy as np

# Création du graphe
G = nx.Graph()

# Ajout de 100 nœuds représentant les satellites
num_satellites = 10
for i in range(1, num_satellites + 1):
    G.add_node(i, pos=(random.uniform(0, 10), random.uniform(0, 10), random.uniform(0, 10)))

# Ajout d'arêtes si la distance est inférieure à 10 km
for i in range(1, num_satellites + 1):
    for j in range(i + 1, num_satellites + 1):
        pos_i = G.nodes[i]['pos']
        pos_j = G.nodes[j]['pos']
        distance = ((pos_i[0] - pos_j[0])**2 + (pos_i[1] - pos_j[1])**2 + (pos_i[2] - pos_j[2])**2)**0.5
        if distance <5:
            G.add_edge(i, j)


# 3d spring layout
pos = nx.spring_layout(G, dim=3, seed=779)
# Extract node and edge positions from the layout
node_xyz = np.array([pos[v] for v in sorted(G)])
edge_xyz = np.array([(pos[u], pos[v]) for u, v in G.edges()])

# Create the 3D figure
fig = plt.figure()
ax = fig.add_subplot(111, projection="3d")

# Plot the nodes - alpha is scaled by "depth" automatically
ax.scatter(*node_xyz.T, s=100, ec="w")

# Plot the edges
for vizedge in edge_xyz:
    ax.plot(*vizedge.T, color="tab:gray")


def _format_axes(ax):
    """Visualization options for the 3D axes."""
    # Turn gridlines off
    ax.grid(False)
    # Suppress tick labels
    for dim in (ax.xaxis, ax.yaxis, ax.zaxis):
        dim.set_ticks([])
    # Set axes labels
    ax.set_xlabel("x")
    ax.set_ylabel("y")
    ax.set_zlabel("z")


_format_axes(ax)
fig.tight_layout()
plt.show()