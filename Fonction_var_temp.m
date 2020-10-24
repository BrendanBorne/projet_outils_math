function[Var_temp] = Fonction_var_temp(Tmoy)

  global AmpT
  
  Var_temp = Tmoy + 0.5*AmpT*cos((2*pi*t)/365);

endfunction