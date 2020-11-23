function[Flux_nutriment, Flux_phyton, Flux_mety] = NPZ(N, P, Z)
global Vm
global ks
global Rm
global g
global lambda
global e
global gamma
global fIo

global dt  %pas de temps, pour les apports habdomadaires des bucherons

%A LIRE : je n'ai ajout‚ que l'utilisation des lieux d'aisance pas un seul bucheron, mais il y a un nombre variable de bucherons

Flux_nutriment = -((Vm*N)/(ks + N))*fIo*P + (1-gamma)*Z*Rm*(1-exp(-lambda*P)) + e*P + g*Z + (0.00052/7)*dt;

Flux_phyton = ((Vm*N)/(ks + N))*fIo*P - Z*Rm*(1-exp(-lambda*P)) - e*P;

Flux_mety = gamma*Z*Rm*(1-exp(-lambda*P)) - g*Z;

endfunction