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

function solveKnapInstance(filename)

    price, weight, capacity = readKnaptxtInstance(filename)
    n = length(price)
    table = zeros(Int, n+1, capacity+1)
    c = capacity
    indObjSele = []
    
    

    for i in 2:(n+1)
        for w in 2:(capacity+1)
            if weight[i-1]  < w
                table[i, w] = max(table[i-1, w], table[i-1, w-weight[i-1]] + price[i-1])
            else
                table[i, w] = table[i-1, w]
            end
        end
    end
    BestProfit = table[n+1, capacity+1]

    # récupération des objets mis dans le sac
    for i in n+1:-1:2
        if table[i, c+1] != table[i-1, c+1]
            push!(indObjSele, i-1)
            c -= weight[i-1]
        end
        if c <= 0
            break
        end     
    end
    
    bestSol = zeros(Int, n)
    for i in indObjSele
        bestSol[i] = 1
    end

    return BestProfit, bestSol,table


    

end

function solveNdisplayKnap(filename)

    println("\n Branch-and-Bound for solving a knapsack problem. \n\n Solving instance '" * filename * "'\n")

    BestProfit, bestsol, table = solveKnapInstance(filename)

    println("\n******\n\nOptimal value = ", BestProfit, "\n\nOptimal x=",bestsol)
    println(table)

    
end

INSTANCE = "InstancesKnapSack/test.opb.txt"

solveNdisplayKnap(INSTANCE)

println("press enter to exit ! ")
