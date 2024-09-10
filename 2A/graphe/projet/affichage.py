import graphes



# Charger les données de mobilité pour les trois configurations de densité
file_low = 'topology_low.csv'
file_avg = 'topology_avg.csv'
file_high = 'topology_high.csv'

# Affichage d'un graphe de portée 20 km
graphes.visualize_graph(file_low, 'topology_low', 20)
graphes.visualize_graph(file_avg, 'topology_avg', 20)
graphes.visualize_graph(file_high, 'topology_high', 20)

# Affichage d'un graphe de portée 40 km
graphes.visualize_graph(file_low, 'topology_low', 40)
graphes.visualize_graph(file_avg, 'topology_avg', 40)
graphes.visualize_graph(file_high, 'topology_high', 40)

# Affichage d'un graphe de portée 60 km
graphes.visualize_graph(file_low, 'topology_low', 60)
graphes.visualize_graph(file_avg, 'topology_avg', 60)
graphes.visualize_graph(file_high, 'topology_high', 60)
