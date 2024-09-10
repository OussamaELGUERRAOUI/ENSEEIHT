function bellman_ford(matrice_adjacence, source)
    
    nb_sommets = size(matrice_adjacence, 1)
    # Initialisation tableau des distances de taille nb_sommets rempli d'infini
    distances = fill(Inf, nb_sommets)
    # Initialisation tableau des predecesseurs de taille nb_sommets rempli de 0
    predecesseurs = fill(0, nb_sommets)
   
    
    distances[source] = 0

    
    for i in 1:nb_sommets
        for j in 1:nb_sommets
            poids = matrice_adjacence[j, i]
            if poids != Inf && distances[j] + poids < distances[i]
                distances[i] = distances[j] + poids
                predecesseurs[i] = j
            end
        end
    end
    

    return distances, predecesseurs
end

function chemin_plus_court(predecesseurs, sommet_depart, sommet_arrivee)
    chemin = [sommet_arrivee]
    sommet_actuel = sommet_arrivee
    
    while sommet_actuel != sommet_depart
        sommet_actuel = predecesseurs[sommet_actuel]
        pushfirst!(chemin, sommet_actuel)
    end
    
    return chemin
end

# Exemple d'utilisation
matrice_adjacence = couts = [Inf 3 Inf Inf 5 Inf; 
Inf Inf 4 Inf Inf Inf; 
Inf Inf Inf 2 Inf Inf; 
Inf Inf Inf Inf Inf 3; 
Inf -1 Inf 9 Inf Inf; 
Inf Inf Inf Inf Inf Inf]

source = 1
destination = 6

distances, predecesseurs = bellman_ford(matrice_adjacence, source)
chemin_optimal = chemin_plus_court(predecesseurs, source, destination)

println("Distances depuis le sommet $source : ", distances)
println("Chemin optimal entre $source et $destination : ", chemin_optimal)
println("Coût du chemin optimal : ", distances[destination])
