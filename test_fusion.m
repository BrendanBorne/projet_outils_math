%MODELE NPZ

close all;
clear all;

%VARIABLES

global Vm
global ks
global Rm
global g
global lambda
global e
global gamma
global fIo

Vm = 1;        %en jour^-1, taux max d'assimilation d'azote par le phyton
ks = 1;        %en micromole, cstte de demi-saturation de l'azote par le phyton
Rm = 1;        %en jour^-1, taux max de broutage du phyton par les m�tynnis
g = 0.2;       %en jour^-1, taux de mortalit� des m�tynnis
lambda = 0.2;  %en micromol d'azote par L, cstte d'Ivlev pour le broutage
e = 0.1;       %en jour^-1, taux de mortalit� du phyton
gamma = 0.7;   %proportion d'azote assimil� par les m�tynnis
fIo = 0.25;    %fonction de l'intensit� de la lumi�re 

Tmax = 365*9;    %temps maximal de la simulation
dt = 0.5;        %pas de temps
Time = [0];    %tableau qui stocke le temps

N = 4;        %effectifs initiaux nutriments
P = 2.5;      %effectifs initiaux phyton
Z = 0.5;      %effectifs initiaux m�tynnis

Effectifs_mety = [Z];
Effectifs_nutriment = [N];
Effectifs_phyton = [P];

%CALCUL (RUNGE KUTTA)

for t = 0:dt:Tmax
  [NK1, PK1, ZK1] = NPZ(N, P, Z);
  [NK2, PK2, ZK2] = NPZ(N + 0.5*NK1*dt, P + 0.5*PK1*dt, Z + 0.5*ZK1*dt);
  [NK3, PK3, ZK3] = NPZ(N + 0.5*NK2*dt, P + 0.5*PK2*dt, Z + 0.5*ZK2*dt);
  [NK4, PK4, ZK4] = NPZ(N + NK3*dt, P + PK3*dt, Z + ZK3*dt);
  
  N = N + dt*(NK1/6 + NK2/3 + NK3/3 + NK4/6);
  P = P + dt*(PK1/6 + PK2/3 + PK3/3 + PK4/6);
  Z = Z + dt*(ZK1/6 + ZK2/3 + ZK3/3 + ZK4/6);
 
  Effectifs_mety = [Effectifs_mety Z];
  Effectifs_nutriment = [Effectifs_nutriment N];
  Effectifs_phyton = [Effectifs_phyton P];
  Time = [Time t];
endfor


%REPRESENTATION GRAPHIQUE

figure(1);
hold on;
plot(Time, Effectifs_mety, 'r');
plot(Time, Effectifs_nutriment, 'b');
plot(Time, Effectifs_phyton, 'g');
legend('M�tynnis', 'Nutriments', 'Phyton');
title('Evolution des effectifs de m�tynnis, nutriments et phyton en fonction du temps');



"___________________________________________________________________________________________________________"





global cT
global Kref
global Linf
global f
global AmpT
global Ta
global Tref


%VARIABLES POUR K
Tmoy = 273+29;                               %temp�rature moyenne not�e en kelvin
temperature = Tmoy;
AmpT = 16;                                   %amplitude thermique
Tref = 310;
Kref = 0.031/30;                             %on divise par 30 pour passer de mois en jours
Ta = 9500;                                   %temp�rature d'Arhenius


%AUTRES VARIABLES
Linf = 150;                                  %cm
L = 7;                                       %longueur initiale                              %on regarde chaque jour pendant 10 ans
Xk = 0.14;                                   %valeur de demi saturation, en micromoles d'azote par litre
x = 0;


%TABLEAUX
Lt = [L];                                    %vecteur qui stocke les longueurs
tt = [0];                                    %stockage du temps
temp = [temperature];




%CALCUL
for t = 1:dt:Tmax 
  x = x+1;                                        
  [temperature, cT] = Fonction_var_temp(Tmoy, t);  
  N = Effectifs_mety(1,x);
  f = N/(Xk + N);                                          %r�ponse fonctionnelle
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
plot(tt, Lt, 'r');
