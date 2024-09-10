# Ecrire les tests de l'algorithme du pas de Cauchy
using Test


function tester_cauchy(cauchy::Function)
    tol_test = 1e-1

	@testset "Pas de Cauchy" begin
        g = [0 ; 0]
        H = [7 0 ; 0 2]
        Δ = 1
        s = cauchy(g,H,Δ)
        @test  s ≈ [0.0 ; 0.0] atol = tol_test

        # le cas de test 2 H definie positive
        g = [6 ; 2]
        H = [7 0 ; 0 2]
        Δ = 0.5       # sol = pas de Cauchy  
        s = cauchy(g,H,Δ)
        @test  s ≈ -Δ*g/norm(g) atol = tol_test
        

        
        g = [1,2]
        H = [1 0 ; 0 -1]
        Δ = 1.       # g^T H g < 0 première direction concave
        s = cauchy(g,H,Δ)
        @test  s ≈ -Δ*g/norm(g) atol = tol_test
        g = [1,0]
        Δ = 0.5       #  g^T H g > 0 sol pas de Cauchy
        s = cauchy(g,H,Δ)
        @test  s ≈ -Δ*g/norm(g) atol = tol_test
        
        g = [2 ; 0]
        H = [4 0 ; 0 -15]
        Δ = 2
        s = cauchy(g,H,Δ)
        @test  s ≈ [-0.5 ; 0.0] atol = tol_test
       
    end

end