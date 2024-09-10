# -*- coding: utf-8 -*-
"""
Created on Wed Jan  3 14:49:52 2024

@author: elgue
"""
import networkx as nx
import matplotlib.pyplot as plt
import Donnees
import random
import math
import numpy as np




def Distance(xi,yi,zi,xj,yj,zj):
    return math.sqrt((xi-xj)**2 + (yi-yj)**2 + (zi-zj)**2)/1000 # en km





def createGraph(File,portee,is2d=True):
    
    df = Donnees.recuDonnees(File)
    G = nx.Graph()
    l = []
    # ajouter les noeuds
    for i in range(len(df)):  # i = id
        Point = Donnees.GetPoint(i, df)
        if is2d:
            G.add_node(i, pos=(Point[0],Point[1]))
        else:
            G.add_node(i, pos=(Point[0],Point[1],Point[2]))
       
        
        
    # ajouter les arrêt
    

    
    
    for i in range(len(df)):
        for j in range(i+1,len(df)):
            Pointi = Donnees.GetPoint(i, df)
        
            Pointj = Donnees.GetPoint(j, df)
            
            distance = Distance(Pointi[0],Pointi[1],Pointi[2],Pointj[0],Pointj[1],Pointj[2])
            
            if distance <= portee:
            
                G.add_edge(i,j)
            
                
                
    return G


#generer une liste des couleurs
def generate_random_colors(num_colors):
    colors = []
    for _ in range(num_colors):
        color = "#{:06x}".format(random.randint(0, 0xFFFFFF)) # Générer une couleur hexadécimale aléatoire
        colors.append(color)
    return colors


#visualiser le graphe
def visualize_graph(File, nom,portee):
    # positions for all nodes
    graph = createGraph(File,portee)
    df = Donnees.recuDonnees(File)
    #pos = nx.spring_layout(graph)
    pos = Donnees.AllPosition(df)
    
    colorList = generate_random_colors(100)
    
   
    
    
    #liste = list(graph.nodes(data='label'))
    #labels_nodes = {}
    #for noeud in liste:
        #labels_nodes[noeud[0]]=noeud[0]
    
    #nx.draw_networkx_labels(graph, pos, labels=labels_nodes, font_size=2, \
    #                    font_color='black', \
     #                   font_family='sans-serif')
        
        
    #labels_edges = {}
    #labels_edges = {edge:'' for edge in graph.edges}        
    # edges
    #nx.draw_networkx_edges(graph, pos,width=2)
   # nx.draw_networkx_edge_labels(graph, pos, edge_labels=labels_edges, font_color='red')
    
    #plt.title(nom)
    #plt.axis('on')
    #plt.savefig( nom + '.png')
    #plt.show()
    # Extraction des positions des nœuds pour l'affichage
    node_positions = nx.get_node_attributes(graph, 'pos')
    
    # Affichage du graphe
    nx.draw(graph, pos=node_positions, with_labels=True, font_weight='bold', node_size=200, node_color= colorList, font_color='black')
    plt.title('Graphe des Satellites de portée ' + str(portee) + ' km')
    plt.show()
    
file_low = 'topology_low.csv'
visualize_graph(file_low, 'topology_low', 20)
