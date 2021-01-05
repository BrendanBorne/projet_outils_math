close all;
clear all;

### SIMULATION DE L'ETANG

#VARIABLES

#Globales fonction NPZ
global Vm
global ks
global Rm
global g
global lambda
global e
global gamma
global fIo

#Globales fonction croissance
global cT
global Kref
global Linf
global f
global AmpT
global Ta
global Tref

#Bucherons
TAB_bucherons = load('Bucherons.txt');          %tableau des bucherons
bucherons = 0;                                  %nombre de bucherons
debut_bucherons = input("Jour d'arrivee des premiers bucherons ? ");

#Autres
Vm = 1;                                         %en jour^-1, taux max d'assimilation d'azote par le phyton
ks = 1;                                         %en micromole, cstte de demi-saturation de l'azote par le phyton
Rm = 1;                                         %en jour^-1, taux max de broutage du phyton par les métynnis
g = 0.2;                                        %en jour^-1, taux de mortalité des metynnis
lambda = 0.2;                                   %en micromol d'azote par L, cstte d'Ivlev pour le broutage
e = 0.1;                                        %en jour^-1, taux de mortalité du phyton
gamma = 0.7;                                    %proportion d'azote assimile par les metynnis
fIo = 0.25;                                     %fonction de l'intensite de la lumiere 

#Temps
Tmax = 365*9;                                   %temps maximal de la simulation
dt = 0.5;                                       %pas de temps
Time = [0];                                     %Stockage temps

N = 4;                                          %effectifs nutriments
P = 2.5;                                        %effectifs phyton
Z = 0.5;                                        %effectifs methynnis

#Tableaux concentrations
Effectifs_mety = [Z];
Effectifs_nutriment = [N];
Effectifs_phyton = [P];

# CALCUL DES CONCENTRATIONS DANS L'ETANG

for t = dt:dt:Tmax
  
  if any(TAB_bucherons(:,1) + debut_bucherons == floor(t)) == 1  
    bucherons = TAB_bucherons(find(TAB_bucherons(:,1) + debut_bucherons == floor(t)), 2);  
   elseif floor(t) >= TAB_bucherons(length(TAB_bucherons),1) + 1 + debut_bucherons
    bucherons = 0;
  endif
  
  [NK1, PK1, ZK1] = NPZ(N, P, Z);
  [NK2, PK2, ZK2] = NPZ(N + 0.5*NK1*dt, P + 0.5*PK1*dt, Z + 0.5*ZK1*dt);
  [NK3, PK3, ZK3] = NPZ(N + 0.5*NK2*dt, P + 0.5*PK2*dt, Z + 0.5*ZK2*dt);
  [NK4, PK4, ZK4] = NPZ(N + NK3*dt, P + PK3*dt, Z + ZK3*dt);
  
  N = N + dt*(NK1/6 + NK2/3 + NK3/3 + NK4/6) + bucherons*(0.00052)*dt;
    if N <= 0
      N = 0;
    endif
  P = P + dt*(PK1/6 + PK2/3 + PK3/3 + PK4/6);
  Z = Z + dt*(ZK1/6 + ZK2/3 + ZK3/3 + ZK4/6) - bucherons*(0.0041/7)*dt;
    if Z <= 0
      Z = 0;
    endif
 
  Effectifs_mety = [Effectifs_mety Z];
  Effectifs_nutriment = [Effectifs_nutriment N];
  Effectifs_phyton = [Effectifs_phyton P];
  Time = [Time t];
  
endfor

#REPRESENTATION
figure(1);
hold on;
plot(Time, Effectifs_mety, 'r');
plot(Time, Effectifs_nutriment, 'b');
plot(Time, Effectifs_phyton, 'g');
legend('Metynnis', 'Nutriments', 'Phyton');
title('Evolution des effectifs de metynnis, nutriments et phyton en fonction du temps');
xlabel("Temps en jours");
ylabel("micromoles d'azote");

#___________________________________________________________________________________________________________

          ### SIMULATION DE LA CROISSANCE DU MARSUPILAMI

#VARIABLES POUR K
Tmoy = 273+31.995;                       %température moyenne notée en kelvin
temperature = Tmoy;
AmpT = 10.366;                           %amplitude thermique
Tref = 310;
Kref = 0.031/30;                         %on divise par 30 pour passer de mois en jours
Ta = 9000;                               %température d'Arhenius


#AUTRES VARIABLES
Linf = 150;                              %cm
L = 7;                                   %longueur initiale                             
Xk = 0.14;                               %valeur de demi saturation, en micromoles d'azote par litre
x = 0;
Met = 0;                                 %densit‚ en methynnis

#TABLEAUX
Lt = [L];                                %vecteur qui stocke les longueurs                             
temp = [temperature];

#CALCUL : TEMPERATURE ET TAILLE
for t = dt:dt:Tmax 
  
  x = x+1;                                       
  [temperature, cT] = Fonction_var_temp(Tmoy, t);  
  Met = Effectifs_mety(1,x);
  f = Met/(Xk + Met);                    %reponse fonctionnelle
  
  K1 = Fonction_var_taille(L);
  K2 = Fonction_var_taille(L + 0.5*dt*K1);
  K3 = Fonction_var_taille(L + 0.5*dt*K2);
  K4 = Fonction_var_taille(L + dt*K3);
  
  L = L + dt*(K1/6 + K2/3 + K3/3 + K4/6);
  
  Lt = [Lt L];
  temp = [temp temperature];
endfor

#REPRESENTATION
figure(2);
plot(Time, Lt);
title('Croissance du Marsupilami');
xlabel('Temps en jours');
ylabel('Taille en cm');

