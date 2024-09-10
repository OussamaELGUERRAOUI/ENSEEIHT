import Pkg; 
Pkg.add("GraphRecipes"); Pkg.add("Plots"); 
using GraphRecipes, Plots #only used to visualize the search tree at the end of the branch-and-bound

function readKnaptxtInstance(filename)
    price=Int64[]
    weight=Int64[]
    KnapCap=Int64[]
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



function testSondability_LP( capacity,  borne, BestProfit, Bestsol)
   
    TA, TO, TR = false, false, false
    
    

    if capacity < 0  # Test d'Admissibilité
        TA = true
        
        println("TA")
        
    elseif (borne < BestProfit)  # Test d'optimalite
        TO = true
        
        println("TO")
        
    elseif (capacity == 0) || (borne == BestProfit)  # Test de resolution
        TR = true
        
        println("TR")
       
        
    else
        
        println("non sondable")
        
    end
    return TA, TO, TR, Bestsol, BestProfit
end


function separateNodeThenchooseNext_lexicographic_depthfirst!(listobjs, listvals, n)
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


function exploreNextNode_depthfirst!(listobjs, listvals, listnodes)
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
            println("while")
        end
        if theval==1.0
            push!(listobjs,obj)
            push!(listvals,0.0)
            println("if1")
            println("listvals2if" , listvals)
        else
            println("\nFINISHED")
            stop=true
        end
    else
        #the root node was sondable
        println("\nFINISHED")
        stop=true
    end

    println("listvals2" , listvals)
    return stop

end


function Bornes1(price,weight, capacity, listjobs,listvals, BestProfit, Bestsol, option)
    
    
    borne = 0
    prix = 0
    max = 0

    

    
 
    
    current_weight = 0
    current_price = 0
    for i in 1:length(listjobs)
        if listvals[i] == 1
            current_weight += weight[listjobs[i]]
            current_price += price[listjobs[i]]
        end
               
    end

    if current_price >= BestProfit
        Bestsol = copy(listjobs)
        BestProfit = current_price
    end
    
        
    
    if (length(listjobs) < length(price))
            
        for i in (length(listjobs)+1):length(price)
            r = price[i]/weight[i]
            if (!(i in listjobs)) 
                if r > max        
                    max = r
            
               end     
            
            end
        end
            
        borne = prix + max*capacity
        
    else
        
        borne = prix
        
    end

    

    return borne, capacity, BestProfit, Bestsol

  
end


function Bornes11(price,weight, capacity, listobjs,listvals, BestProfit, Bestsol, option)
    borne = 0
    prix = 0
    max = 0

    weightAct = 0
    priceAct = 0
    for i in 1:length(listobjs)
        if listvals[i] == 1
            weightAct += weight[listobjs[i]]
            priceAct += price[listobjs[i]]
        end
               
    end

    if priceAct >= BestProfit
        Bestsol = copy(listobjs)
        BestProfit = priceAct
    end

    borne = priceAct
    
        
    
   # if (length(listobjs) < length(price))
            
    #    for i in 1:length(price)
     #       r = price[i]/weight[i]
      #      if (!(i in listobjs)) 
       #         if r > max        
        #            max = r
            
         #      end     
            
        #    end
        #end
            
       # borne = priceAct + max*capacity
        
    #else
        
     #   borne = priceAct
        
    #end 
end

function Bornes(price,weight, capacity, listobjs,listvals, BestProfit, Bestsol, option)
    
    
    borne = 0
    prix = 0
    max = 0

    
    if option == 1
        weightAct = 0
        priceAct = 0
        for i in 1:length(listobjs)
            if listvals[i] == 1
                capacity = capacity -  weight[listobjs[i]]
                priceAct += price[listobjs[i]]
            end
                   
        end

        for i in 1:length(price)
            r = price[i]/weight[i]
            if (!(i in listobjs)) 
                if r > max        
                    max = r
                end
            
            end
        end
        #
        priceAct += max*capacity

    
        if priceAct >= BestProfit
            Bestsol = copy(listobjs)
            BestProfit = priceAct
        end
        
            
        
        #if (length(listobjs) < length(price))
                
         #   for i in (length(listobjs)+1):length(price)
          #      r = price[i]/weight[i]
           #     if (!(i in listobjs)) 
            #        if r > max        
             #           max = r
                
              #     end     
                
               # end
            #end
                
        borne = priceAct
            
        #else
            
         #   borne = priceAct
            
        #end
        
    elseif option == 2
        for i in 1:length(listobjs)
            if listvals[i] == 1
                capacity = capacity - weight[listobjs[i]]
                println("capacity2 =", capacity)
                prix = prix + price[listobjs[i]]
                
            end
        end
    
        deleteat!(price, listobjs)
        deleteat!(weight, listobjs)
    
        if capacity >= 0
            if prix > BestProfit
                BestProfit = prix
                Bestsol= copy(listobjs)
            end
        end
        
        
        #ration
        r = price./weight
        listR = [(r[i], weight[i]) for i in 1:length(price)]
        listR = sort(listR, by = x -> x[1], rev=true)
        prix1 = 0

        for i in 1:length(listR)
            if listR[i][2] <= capacity
                prix1 = prix1 + listR[i][1]*listR[i][2]
                capacity = capacity - listR[i][2]
            else
                break
            end
        end

        borne = prix + prix1
    end

         
return borne, capacity, BestProfit, Bestsol
        
end


function solveKnapInstance(filename)

    price, weight, capacity = readKnaptxtInstance(filename)
    n = length(price)

    #model2, x = createModel_LP(price, weight, capacity)

    #create the structure to memorize the search tree for visualization at the end
    trParentnodes=Int64[] #will store orig node of arc in search tree
    trChildnodes=Int64[] #will store destination node of arc in search tree
    trNamenodes=[] #will store names of nodes in search tree

    #intermediate structure to navigate in the search tree
    listobjs=Int64[]
    listvals=Float64[]
    listnodes=Int64[]

    BestProfit::Float64=-1.0
    Bestsol=Float64[]

    current_node_number::Int64=0
    stop = false

    while(!stop)

        println("\nNode number ", current_node_number, ": \n---------------\n")

        #Update the graphical tree
        push!(trNamenodes,current_node_number+1) 
        if(length(trNamenodes)>=2)
            push!(trParentnodes,listnodes[end]+1) # +1 because the 1st node is "node 0"
            push!(trChildnodes, current_node_number+1) # +1 because the 1st node is "node 0"
        end
        push!(listnodes, current_node_number)

        
        #create LP of current node
        #updateModele_LP!(model2, x, listobjs, listvals)
        
        #println(model2)
        
        print("Solve the LP model of the current node to compute its bound: start ... ")

        #status = optimize!(model2)

        priceAct = deepcopy(price)
        weightAct = deepcopy(weight)
        capacityAct = capacity

       
        option = 1
        
        borne, capacityAc, Bestp, BestS = Bornes(priceAct, weightAct, capacityAct, listobjs,listvals, BestProfit, Bestsol, option)

        BestProfit = Bestp

        Bestsol = BestS

        println("bestProfit=", BestProfit, " bestsol=", Bestsol)



        println("capacityAct =", capacityAct)

        println("listvals =", listvals)




        TA, TO, TR = testSondability_LP( capacityAc,  borne, Bestp, BestS)

        is_node_sondable = TA || TO || TR

        #Reset_LP!(model2, x, listobjs)

        if (!is_node_sondable)
            separateNodeThenchooseNext_lexicographic_depthfirst!(listobjs, listvals, n)
            println("1")

        else
            stop = exploreNextNode_depthfirst!(listobjs, listvals, listnodes)
            println("2")
        end
        
        #resetAll_LP!(model2, x)

        current_node_number = current_node_number + 1
    end

    println("\n******\n\nOptimal value = ", BestProfit, "\n\nOptimal x=", Bestsol)

    return BestProfit, Bestsol, trParentnodes, trChildnodes, trNamenodes

end


function solveNdisplayKnap(filename)

    println("\n Branch-and-Bound for solving a knapsack problem. \n\n Solving instance '" * filename * "'\n")

    BestProfit, Bestsol, trParentnodes, trChildnodes, trNamenodes = solveKnapInstance(filename)

    println("\n******\n\nOptimal value = ", BestProfit, "\n\nOptimal x=", Bestsol)

    println("\n Branch-and-bound tree visualization : start display ...")
    display(graphplot(trParentnodes, trChildnodes, names=trNamenodes, method=:tree))
    println("... end display. \n\n")

end

INSTANCE = "InstancesKnapSack/test.opb.txt"

solveNdisplayKnap(INSTANCE)

println("press enter to exit ! ")
readline()