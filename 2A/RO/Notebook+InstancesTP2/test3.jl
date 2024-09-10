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


# function TestsSondabilite_LP(model2, x, BestProfit, Bestsol)
#     TA, TO, TR = false, false, false
#     if(termination_status(model2) == MOI.INFEASIBLE)#Test de faisabilite
#         TA=true
#         println("TA")
#     elseif(objective_value(model2) <= BestProfit) #Test d'optimalite
#         TO=true
#         println("TO")
#     elseif( prod(abs.([round.(v, digits=0) for v in value.(x)]-value.(x)) .<= fill(10^-5, size(x))) 
#         ) #Test de resolution
#         TR=true
#         println("TR")
#         #if (value(benef) >= BestProfit)
#         if (objective_value(model2) >= BestProfit)
#             Bestsol = value.(x)
#             #BestProfit=value(benef)
#             BestProfit=objective_value(model2)
#             println("\nNew Solution memorized ", Bestsol, " with bestprofit ", BestProfit, "\n")
#         end
#     else
#         println("non sondable")
#     end
#     TA, TO, TR, Bestsol, BestProfit
# end


function TestsSondabilite(listobjs, listvals, price, weight, capacity, borneinf, bornesup, BestProfit, Bestsol, affichage)
    TA, TO, TR = false, false, false
    
    current_weight = 0
    current_price = 0
    for i in 1:length(listobjs)
        if listvals[i] == 1
            current_weight += weight[listobjs[i]]
            current_price += price[listobjs[i]]
        end
               
    end

    if current_weight > capacity  # Test d'Admissibilité
        TA = true
        if affichage
            println("TA")
        end
    elseif (bornesup < BestProfit)  # Test d'optimalite
        TO = true
        if affichage
            println("TO")
        end
    elseif borneinf == bornesup # Test de resolution
        TR = true
        if affichage
            println("TR")
        end
        if bornesup >= BestProfit
            Bestsol = copy(listobjs)
            BestProfit = bornesup
            if affichage
                println("\nNew Solution memorized ", Bestsol, " with bestprofit ", BestProfit, "\n")
            end
        end
    else
        if affichage
            println("non sondable")
        end
    end
    return TA, TO, TR, Bestsol, BestProfit
end



    

function SeparerNoeud_lexicographic_depthfirst!(listobjs, listvals, n,  price, weight, affichage)
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
    println("listvals1" , listvals)
end


function ExplorerAutreNoeud_depthfirst!(listobjs, listvals, listnodes, affichage)
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
            if affichage
                println("\nFINISHED")
            end
            stop=true
        end
    else
        #the root node was sondable
        if affichage
            println("\nFINISHED")
        end
        stop=true
    end
    return stop 
end  

function Bornes_1!(price, weight, capacity, listobjs, listvals)
    
    placeDispo, prixEnCours, obj, maxr = capacity, 0.0, 0, -1.0
    for i in 1:length(listobjs)
        if listvals[i] == 1
            placeDispo -= weight[listobjs[i]]
            prixEnCours += price[listobjs[i]]
        end
    end 

    if (length(listobjs) < length(price))
        for i in 1:length(price)
            if (!(i in listobjs)) && ((price[i]/weight[i]) >= maxr)
                maxr = (price[i]/weight[i])
                obj = i
            end
        end
        facteurObj = placeDispo/weight[obj]

        borneinf, bornesup = prixEnCours, (prixEnCours+facteurObj*price[obj])
    else 
        borneinf, bornesup = prixEnCours, prixEnCours
    end
    return borneinf, bornesup

end


function SolveKnapInstance(filename, borne, affichage)

    price, weight, capacity = readKnaptxtInstance(filename)

    #model2, x = CreationModele_LP(price, weight, capacity)

    #create the structure to memorize the search tree for visualization at the end
    trParentnodes=Int64[] #will store orig node of arc in search tree
    trChildnodes=Int64[] #will store destination node of arc in search tree
    trNamenodes=[] #will store names of nodes in search tree

    #intermediate structure to navigate in the search tree
    listobjs=[]
    listvals=[]
    listnodes=[]

    BestProfit=-1
    Bestsol=[]

    current_node_number=0
    stop = false

    while(!stop)
        if affichage
            println("\nNode number ", current_node_number, ": \n---------------\n")
        end
        #Update the graphical tree
        push!(trNamenodes,current_node_number+1) 
        if(length(trNamenodes)>=2)
            push!(trParentnodes,listnodes[end]+1) # +1 because the 1st node is "node 0"
            push!(trChildnodes, current_node_number+1) # +1 because the 1st node is "node 0"
        end
        push!(listnodes, current_node_number)

        #=
        #create LP of current node
        MajModele_LP!(model2, x, listobjs, listvals)
        
        println(model2)
        
        print("Solve the LP model of the current node to compute its bound: start ... ")

        status = optimize!(model2)

        println("... end"); 

        print(": Solution LP")
        if(termination_status(model2) == MOI.INFEASIBLE)#(has_values(model2))
            print(" : NOT AVAILABLE (probably infeasible or ressources limit reached)")
        else
            print(" ", objective_value(model2))
            [print("\t", name(v),"=",value(v)) for v in all_variables(model2)] 
        end
        println(" "); 

        =#

        #println("listobjs, listvals, listnodes", listobjs, listvals, listnodes)
        #Calcul des bornes
        if borne == "borne1"
            borneinf, bornesup = Bornes_1!(price, weight, capacity, listobjs, listvals)
        else borne == "borne2"
            borneinf, bornesup = Bornes_2!(price, weight, capacity, listobjs, listvals)
        end
        if (affichage==true)
            println("bornes :", [borneinf, bornesup])
            println("\nPrevious Solution memorized ", Bestsol, " with bestprofit ", BestProfit, "\n")
        end
        
        TA, TO, TR, Bestsol, BestProfit = TestsSondabilite(listobjs, listvals, price, weight, capacity, borneinf, bornesup, BestProfit, Bestsol, affichage)
        
        is_node_sondable = TA || TO || TR

        #Reset_LP!(model2, x, listobjs)

        
        if(!is_node_sondable)
            SeparerNoeud_lexicographic_depthfirst!(listobjs, listvals, length(price), price, weight, affichage)
        else
            stop = ExplorerAutreNoeud_depthfirst!(listobjs, listvals, listnodes, affichage)        
        end
        
        
        
        #Reset_allLP!(model2, x)

        current_node_number = current_node_number + 1
    end
    if affichage
        println("\n******\n\nOptimal value = ", BestProfit, "\n\nOptimal x=", Bestsol)
    end
    return BestProfit, Bestsol, trParentnodes, trChildnodes, trNamenodes

end


BestProfit, Bestsol, trParentnodes, trChildnodes, trNamenodes = SolveKnapInstance("InstancesKnapSack/test.opb.txt", "borne1", true)
println("\n******\n\nOptimal value = ", BestProfit, "\n\nOptimal x=", Bestsol)
graphplot(trParentnodes, trChildnodes, names=trNamenodes, method=:tree)


