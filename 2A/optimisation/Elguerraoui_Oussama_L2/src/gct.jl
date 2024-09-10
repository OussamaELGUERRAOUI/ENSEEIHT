using LinearAlgebra
"""
Approximation de la solution du problème 

    min qₖ(s) = s'gₖ + 1/2 s' Hₖ s, sous la contrainte ‖s‖ ≤ Δₖ

# Syntaxe

    s = gct(g, H, Δ; kwargs...)

# Entrées

    - g : (Vector{<:Real}) le vecteur gₖ
    - H : (Matrix{<:Real}) la matrice Hₖ
    - Δ : (Real) le scalaire Δₖ
    - kwargs  : les options sous formes d'arguments "keywords", c'est-à-dire des arguments nommés
        • max_iter : le nombre maximal d'iterations (optionnel, par défaut 100)
        • tol_abs  : la tolérence absolue (optionnel, par défaut 1e-10)
        • tol_rel  : la tolérence relative (optionnel, par défaut 1e-8)

# Sorties

    - s : (Vector{<:Real}) une approximation de la solution du problème

# Exemple d'appel

    g = [0; 0]
    H = [7 0 ; 0 2]
    Δ = 1
    s = gct(g, H, Δ)

"""
function gct(g::Vector{<:Real}, H::Matrix{<:Real}, Δ::Real; 
    max_iter::Integer =100, 
    tol_abs::Real = 1e-10, 
    tol_rel::Real = 1e-8)
 
    function resolEquD2(a,b,c)  # résolution de l'équation du second degré ax²+bx+c=0
        Δ = b^2 - 4*a*c
        if Δ < 0
            return (0, 0)
        elseif Δ == 0
            return (-b/(2*a), -b/(2*a))
        else
            return ((-b + sqrt(Δ))/(2*a), (-b - sqrt(Δ))/(2*a))
        end
        
    end
     
    
    # initialisation
    s = zeros(length(g))
    n = length(g)
    
    j = 0
    g0 = g
    gj = g0
    pj = -g0
   
    
    while (norm(gj) > max(tol_rel*norm(g0), tol_abs)) && (j < max_iter) 

        kj = pj'*H*pj
        if kj <= 0
            
            sol = resolEquD2(norm(pj)^2, 2*pj'*s, norm(s)^2 - Δ^2)   # résolution de l'équation ||s + αpj|| = Δ => ||pj||²x² + 2pj'sx + ||s||² - Δ² = 0
            q1 = gj'*(s + sol[1]*pj) + 1/2*(s + sol[1]*pj)'*H*(s + sol[1]*pj)
            q2 = gj'*(s + sol[2]*pj) + 1/2*(s + sol[2]*pj)'*H*(s + sol[2]*pj)
            if q1 < q2
                s = s + sol[1]*pj 
            else
                s = s + sol[2]*pj
            end
            break
        end
        
        αj = (gj'*gj)/kj
        if norm(s + αj*pj) >= Δ
            
            sol = resolEquD2(norm(pj)^2, 2*pj'*s, norm(s)^2 - Δ^2)   # résolution de l'équation ||s + αpj|| = Δ => ||pj||²x² + 2pj'sx + ||s||² - Δ² = 0
            #solutioon positive
            solp = max(sol[1], sol[2], 0)
            s = s + solp*pj
            break
            
        end
        
        # mise à jour
        s = s + αj*pj
        j = j + 1
        g0 = gj
        gj = gj + αj*H*pj
        βj = (gj'*gj)/(g0'*g0)
        pj = -gj + βj*pj
        
    end 

   return s
end

