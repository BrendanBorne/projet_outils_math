function[Flux_nutriment, Flux_phyton, Flux_mety] = NPZ(N, P, Z)
global Vm
global ks
global Rm
global g
global lambda
global e
global gamma
global fIo

Flux_nutriment = -((Vm*N)/(ks + N))*fIo*P + (1-gamma)*Z*Rm*(1-exp(-lambda*P)) + e*P + g*Z;

Flux_phyton = ((Vm*N)/(ks + N))*fIo*P - Z*Rm*(1-exp(-lambda*P)) - e*P;

Flux_mety = gamma*Z*Rm*(1-exp(-lambda*P)) - g*Z;

endfunction