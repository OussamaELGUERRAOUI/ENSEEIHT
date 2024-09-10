#calcul degré moyen
import networkx as nx
import graphes

def degreMoyen(G):
    degre = 0
    for i in range(len(G)):
        degre += G.degree[i]
    return degre/len(G)

G = graphes.createGraph('topology_low.csv', 20)
print(degreMoyen(G))