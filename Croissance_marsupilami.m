#COMMENTAIRE POUR VOIR SI CA MARCHE
#BRANCHE 

close all;
clear all;

global cT
global Kref
global Linf
global f
global AmpT
global Ta
global Tref


%VARIABLES POUR K
Tmoy = 273+29;                               %température moyenne notée en kelvin
temperature = Tmoy;
AmpT = 16;                                   %amplitude thermique
Tref = 310;
Kref = 0.031/30;                             %on divise par 30 pour passer de mois en jours
Ta = 9500;                                   %température d'Arhenius


%AUTRES VARIABLES
Linf = 150;                                  %cm
L = 7;                                       %longueur initiale
dt = 0.5;  
t_sim = 365*9;                               %on regarde chaque jour pendant 10 ans
Xk = 0.14;                                   %valeur de demi saturation, en micromoles d'azote par litre


%TABLEAUX
metynnis = load('MetynnisStation301.txt');
Lt = [L];   %vecteur qui stocke les longueurs
tt = [0];   %stockage du temps
temp = [temperature];


%CALCUL
for t = dt:dt:t_sim                                          
  [temperature, cT] = Fonction_var_temp(Tmoy, t);  
  N = metynnis(t*2, 2);
  f = N/(Xk + N);                                          %réponse fonctionnelle
  K1 = Fonction_var_taille(L);
  K2 = Fonction_var_taille(L + 0.5*dt*K1);
  K3 = Fonction_var_taille(L + 0.5*dt*K2);
  K4 = Fonction_var_taille(L + dt*K3);
  L = L + dt*(K1/6 + K2/3 + K3/3 + K4/6);
  Lt = [Lt L];
  tt = [tt t];
  temp = [temp temperature];
endfor


%REPRESENTATION
figure(2);
##station = load('301.txt');
##station(:,1) = station(:,1).*30;
##plot(tt, Lt, 'r', station(:,1), station(:,2), '+b');

plot(tt, Lt, 'r');



