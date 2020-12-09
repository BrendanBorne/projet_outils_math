function[Var_temp, cT] = Fonction_var_temp(Tmoy, t)

  global AmpT
  global Ta
  global Tref
  
  Var_temp = Tmoy + (AmpT/2 * sin(((2*pi)/365)*t+89.5));
  cT=exp(Ta/Tref - Ta/Var_temp); 

endfunction