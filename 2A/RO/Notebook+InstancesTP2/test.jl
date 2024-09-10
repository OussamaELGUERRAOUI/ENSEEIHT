import Pkg; 
Pkg.add("GraphRecipes"); Pkg.add("Plots"); 
using GraphRecipes, Plots #only used to visualize the search tree at the end of the branch-and-bound

function readKnaptxtInstance(filename)
    price=[]
    weight=[]
    KnapCap=[]
    open(filename) do f
        for i in 1:3
            tok = split(readline(f))
            if(tok[1] == "ListPrices=")
                for i in 2:(length(tok)-1)
                    push!(price,parse(Int64, tok[i]))
                end
            elseif(tok[1] == "ListWeights=")
                for i in 2:(length(tok)-1)
                    push!(weight,parse(Int64, tok[i]))
                end
            elseif(tok[1] == "Capacity=")
                push!(KnapCap, parse(Int64, tok[2]))
            else
                println("Unknown read :", tok)
            end 
        end
    end
    capacity=KnapCap[1]
    return price, weight, capacity
end


function TestsSondabilite_LP(capacity, poids, bornesup, BestProfit)
    TA, TO, TR = false, false, false
    bool = true
    if (capacity<0)#Test de faisabilite
        TA=true
        println("TA")
    elseif (bornesup <= BestProfit) #Test d'optimalite
        TO=true
        println("TO")
    else
        #Test de resolution
        if ( capacity == 0)
            TR=true
            println("TR")
        else 
            for i in 1:length(poids)
                if (capacity > poids[i])
                    bool = bool && false
                end
            TR = bool
            end
        end

        if (TR = false)
            println("non sondable")
        end
    end
    TA, TO, TR
end





function SeparerNoeud_lexicographic_depthfirst!(listobjs, listvals, n)
    # this node is non-sondable. Apply the branching criterion to separate it into two subnodes
    # and choose the child-node at the left  
    
    # lexicographic branching criterion: branch on the 1st object not yet fixed
    i, obj = 1, 0
    while((i <= n) && (obj==0))
        if(!(i in listobjs))
            obj=i
        end
        i+=1
    end
    
    println("\nbranch on object ", obj, "\n")

    # depthfirst exploration strategy: the node selected will be the most left of the child-nodes just created
    push!(listobjs,obj) #save the identity of the object selected for branching
    push!(listvals,1.0) #save the node selected, identified by the value assigned to the variable/object chosen
end


function ExplorerAutreNoeud_depthfirst!(listobjs, listvals, listnodes)
    #this node is sondable, go back to parent node then right child if possible
    
    stop=false
    #check if we are not at the root node
    if (length(listobjs)>= 1)
        #go back to parent node
        obj=pop!(listobjs)
        theval=pop!(listvals)
        tmp=pop!(listnodes)

        #go to right child if possible, otherwise go back to parent
        while( (theval==0.0) && (length(listobjs)>= 1))
            obj=pop!(listobjs)
            theval=pop!(listvals)
            tmp=pop!(listnodes)
            
        end
        if theval==1.0
            push!(listobjs,obj)
            push!(listvals,0.0)
        else
            println("\nFINISHED")
            stop=true
        end
        
    else
        #the root node was sondable
        println("\nFINISHED")
        stop=true
        
    end
    return stop
end




function calBorne(cout, poids, capacite, val_charge, option)

    # Borne 1
    r = cout./poids
    if option == 1
        borne = capacite * maximum(r; init =0)

    # Borne 2
    elseif option == 2
        borne = 0
        #trier les objets par ri
        if length(cout) > 0
            l = []
            for i in 1:length(cout)
                l = [l;(r[i],poids[i])]
            end
        
            sort!(l, by = x -> x[1], rev=true)
            
            # remplir le sac à dos en mettant d'abord entièrement les objets avec le meilleur ri puis ajouter 
            # la fraction du dernier objet
            for i in 1:length(l)
                while (capacite - l[i][2]) > 0
                    borne = borne + l[i][1]*l[i][2]
                    capacite = capacite - l[i][2]
                end
            end
            
        end
    end
    return (val_charge + borne)
end





function SolveKnapInstance(filename)

    price, weight, capacity = readKnaptxtInstance(filename)
    n = length(price)

    #create the structure to memorize the search tree for visualization at the end
    trParentnodes=Int64[] #will store orig node of arc in search tree
    trChildnodes=Int64[] #will store destination node of arc in search tree
    trNamenodes=[] #will store names of nodes in search tree

    #intermediate structure to navigate in the search tree
    listobjs=[]
    listvals=[]
    listnodes=[]

    BestProfit = -1
    Bestsol=[]

    current_node_number=0
    stop = false

    while(!stop)

        println("\nNode number ", current_node_number, ": \n---------------\n")

        #Update the graphical tree
        push!(trNamenodes,current_node_number+1) 
        if (length(trNamenodes)>=2)
            push!(trParentnodes,listnodes[end]+1) # +1 because the 1st node is "node 0"
            push!(trChildnodes, current_node_number+1) # +1 because the 1st node is "node 0"
        end
        push!(listnodes, current_node_number)

        # Maj de price_courant, weight_courant, capacity_courant
        price_courant = deepcopy(price)
        weight_courant = deepcopy(weight)
        capacity_courant = capacity

        
        
        val_charge = 0
        for i in 1:length(listobjs)
            obj = listobjs[i]
            if listvals[i] == 1
                capacity_courant = capacity_courant - weight[obj]
                # Garder ka valeur des objets dans le sac avant le calcul de la borne
                val_charge = val_charge + price[obj]
            end
        end
        deleteat!(price_courant, listobjs)
        deleteat!(weight_courant, listobjs)

        # Maj de Bestsol et BestProfit
        if capacity_courant >= 0
            if val_charge > BestProfit
                BestProfit = val_charge
                Bestsol = zeros(n)
                for i in 1:length(listobjs)
                    obj = listobjs[i]
                    if listvals[i] == 1
                        Bestsol[obj] = 1
                    end
                end
            end
        end

        println("capacity", capacity_courant)
        
        println("Bestsol : "*string(Bestsol))
        println("BestProfit : "*string(BestProfit))
        println("Capacite : "*string(capacity_courant))

         println("listvals =", listvals)

        # Calcul de la borne sup
        option = 2
        bornesup = calBorne(price_courant, weight_courant, capacity_courant, val_charge, option)
        
        # Test de sondabilité
        TA, TO, TR = TestsSondabilite_LP(capacity_courant, weight_courant, bornesup, BestProfit)
        is_node_sondable = TA || TO || TR

        #Reset_LP!(model2, x, listobjs)

        if (!is_node_sondable)
            SeparerNoeud_lexicographic_depthfirst!(listobjs, listvals, n)
        else
            stop = ExplorerAutreNoeud_depthfirst!(listobjs, listvals, listnodes)
        end
        

        current_node_number = current_node_number + 1
    end

    println("\n******\n\nOptimal value = ", BestProfit, "\n\nOptimal x=", Bestsol)

    return BestProfit, Bestsol, trParentnodes, trChildnodes, trNamenodes

end


BestProfit, Bestsol, trParentnodes, trChildnodes, trNamenodes = SolveKnapInstance("InstancesKnapSack/test.opb.txt")
println("\n******\n\nOptimal value = ", BestProfit, "\n\nOptimal x=", Bestsol)
graphplot(trParentnodes, trChildnodes, names=trNamenodes, method=:tree)