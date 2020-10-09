clear all;
close all;

##PARAMETRES
Vm=1;       #Taux maximum d'assimilation de l'azote par le phyton
Ks=1;       #Constante de demi-saturation de l'assimilation de l'azote par le phyton
Rm=1;       #Taux maximum de broûtage du phyton par les Métynnis
g=0.2;       #Taux de mortalité des Métynnis
lambda=0.2; #Constante d'Ivlev pour le broûtage;
#            C'est une constante empirique couramment utilisée dans les modèles pour figurer le broûtage
e=0.1;      #Taux de mortalité du phyton
gamma=0.7;  #Proportion d'azote assimilée par les Métynnis
fI0=0.25;   #Fonciton de l'intensité de lumière 
#           Habituellement une décroissance exponentielle en fonction de la profondeur
#           Dans le cas présent, la profondeur de l'étang est constante et on fera l'hypothèse que
#           fI0 est constante et égale à 0.25, dans un premier temps du moins

#           Les taux sont exprimés par jour. 

global Vm
global Ks
global Rm
global g
global lambda
global e
global gamma
global fI0

##VARIABLES
N=4;        #Azote (nutriments)
P=2.5;      #Végétaux (phytons)     
Z=0.5;      #Metynnis
#           µmole.N.I^-1

#TABLEAUX DE RESULTATS
tabN=[N];
tabP=[P];
tabZ=[Z];

##TEMPS
t=0;        #En jours
temps=[t];  #Tableau de gestion du temps
dt=0.5;     #Pas de temps
Tmax=365;

##EULER
#{
Ne = 4;
Pe = 2.5;
Ze = 0.5;
tabNe = [Ne];
tabPe = [Pe];
tabZe = [Ze];
#}

##CALCUL
for i=0:dt:Tmax
  ##Runge Kutta
  [NK1, PK1, ZK1] = NPZ(N, P, Z);
  [NK2, PK2, ZK2] = NPZ(N+dt/2*NK1, P+dt/2*PK1, Z+dt/2*ZK1);
  [NK3, PK3, ZK3] = NPZ(N+dt/2*NK2, P+dt/2*PK2, Z+dt/2*ZK2);
  [NK4, PK4, ZK4] = NPZ(N+dt*NK3, P+dt*PK3, Z+dt*ZK3);
  N = N+dt*(NK1/6 + NK2/3 + NK3/3 + NK4/6); 
  P = P+dt*(PK1/6 + PK2/3 + PK3/3 + PK4/6);
  Z = Z+dt*(ZK1/6 + ZK2/3 + ZK3/3 + ZK4/6);
  
  ##Euler
  #{
  [dN, dP, dZ] = NPZ(Ne, Pe, Ze);
  Ne = Ne+dt*dN;
  Pe = Pe+dt*dP;
  Ze = Ze+dt*dZ;
  tabNe=[tabNe;Ne];
  tabPe=[tabPe;Pe];
  tabZe=[tabZe;Ze];
  #}
  

  t=t+dt;
  temps=[temps;t];
  
  tabN=[tabN;N];
  tabP=[tabP;P];
  tabZ=[tabZ;Z];  
end

##AFFICHAGE
figure(1);
hold on;
plot(temps,tabN);
plot(temps,tabP);
plot(temps,tabZ);
##plot(temps,tabNe);
##plot(temps,tabPe);
##plot(temps,tabZe);
hold off;
title("Evolution de la concentration en Azote, Végétaux et Metynnis dans l'étang (µmol.N.l^-1)");
legend("Azote (N)", "Végétaux (P)", "Metynnis (Z)");
grid;