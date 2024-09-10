function res = isEulerien(A)

degres = sum(A)

nb_sommets_imp = sum(mod(degres,2) == 1)

res = nb_sommets_imp == 0 || nb_sommets_imp == 2