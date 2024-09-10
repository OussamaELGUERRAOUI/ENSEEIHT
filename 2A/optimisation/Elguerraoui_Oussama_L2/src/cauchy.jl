using LinearAlgebra
"""
Approximation de la solution du problème 

    min qₖ(s) = s'gₖ + 1/2 s' Hₖ s

        sous les contraintes s = -t gₖ, t > 0, ‖s‖ ≤ Δₖ

# Syntaxe

    s = cauchy(g, H, Δ; kwargs...)

# Entrées

    - g : (Vector{<:Real}) le vecteur gₖ
    - H : (Matrix{<:Real}) la matrice Hₖ
    - Δ : (Real) le scalaire Δₖ
    - kwargs  : les options sous formes d'arguments "keywords", c'est-à-dire des arguments nommés
        • tol_abs  : la tolérence absolue (optionnel, par défaut 1e-10)

# Sorties

    - s : (Vector{<:Real}) la solution du problème

# Exemple d'appel

    g = [0; 0]
    H = [7 0 ; 0 2]
    Δ = 1
    s = cauchy(g, H, Δ)

"""
function cauchy(g::Vector{<:Real}, H::Matrix{<:Real}, Δ::Real; tol_abs::Real = 1e-10)

    s = zeros(length(g))
    # en remplaçant s avec -tgₖ et en dérivant par rapport à t
    # on obtient une équation quadratique en qₖ(s) = 1/2 a t² + b t 

    a = g'*H*g
    b = - norm(g)^2
    
    

    if norm(g) > tol_abs
        t = -b/a             # solution de qₖ'(t) = 0
        tmax = Δ/norm(g)
        if (t > tmax || a <= 0)    # si t n'est pas dans l'intervalle [0, tmax]
            t = tmax
        end
        s= -t*g
    end
    
    return s
end
