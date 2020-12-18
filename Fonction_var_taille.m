function[Var_taille] = Fonction_var_taille(L)
global cT
global Kref
global Linf
global f

Var_taille = cT*Kref*(Linf*f - L);

endfunction

