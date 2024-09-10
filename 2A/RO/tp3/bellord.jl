# matrix_adj est la matrice d'adjacence du graphe
function min(a,b)
    if a[2] < b[2]
        return a
    else
        return b
    end
end
    

function bellman_ford(matrix_adj, source, destination)
    # Initialisation
    n = size(matrix_adj)[1]
    d = zeros(n)
    chemin = []
    
    d[source] = 0
    # Relaxation
    k = source
    fk = 0
    egalite = true
    #debut du chemin
    push!(chemin, k)
    while (k < destination) && egalite
       
        Min = Inf
        nodePrec = k
        # recuperation des couts des arcs sortants de k avec leur destination
        cout = matrix_adj[k, :]
        println(cout)
        #supprime 0
        c = [(node, w) for (node, w) in enumerate(cout) if w != 0]
        
        for i in 1:length(c)
            
            Minc = (nodePrec, Min) # couple du noeud precedent 
            
            minc = min(c[i], Minc)
            Min = minc[2]
            node = minc[1]
            k = node
            println(node)
            
            
        
        end
        
        
        fk = fk + Min
        d[k] = fk
        push!(chemin,k) #ajout de la destination
        
        #verifie fk = fk+1
        #egalite = (fk == d[nodePrec])
    end
    return d, chemin, fk
end

# Exemple
matric_adj = [0 3 0 0 5 0 ;
              0 0 4 0 0 0 ;
              0 0 0 2 0 0 ;
              0 0 0 0 0 3 ;
              0 -1 0 9 0 1 ;
              0 0 0 0 0 0 ]
bellman_ford(matric_adj, 1 , 6 )