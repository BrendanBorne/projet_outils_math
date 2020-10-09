function [FluxN, FluxP, FluxZ] = NPZ(N,P,Z)
  global Vm
  global Ks
  global Rm
  global g
  global lambda
  global e
  global gamma
  global fI0
  
  FluxN = (-(Vm*N)/(Ks+N))*fI0*P + (1-gamma)*Z*Rm*(1-exp(-lambda*P)) + e*P + g*Z;
  FluxP = ((Vm*N)/(Ks+N))*fI0*P - Z*Rm*(1-exp(-lambda*P)) - e*P;
  FluxZ = gamma*Z*Rm*(1-exp(-lambda*P)) - g*Z; 
endfunction
