function[Var_temp, cT] = Fonction_var_temp(Tmoy, t)

  global AmpT
  global Ta
  global Tref
  
  Var_temp = Tmoy + 0.5*AmpT*cos((2*pi*t)/365);
  cT=exp(Ta/Tref - Ta/Var_temp); 

endfunction