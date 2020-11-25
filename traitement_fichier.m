clear all;
close all;

#Importation des donnees
temp=load("Temp2011.txt");
tab=[temp(:,2)];

#Traitement des donnees
tMoy=mean(tab);
amp=max(tab)-min(tab);

#Tableau t pour les donnees importees
t=[];
temp=[];
for i=1:2:365
  t=[t;i]; 
endfor

#Simulation de la temperature
tsim=[];
for i=1:365
  tsim=[tsim;i];
  calcul = tMoy + (amp/2 * sin(((2*pi)/365)*i+89.5));
  temp=[temp;calcul];
endfor

#Apercu des donnees
figure(1);
hold on;
plot(t,tab);
plot(tsim,temp);
title("Evolution de la température aux alentours de l'etang de XFC.678.F9");
xlabel("Jours");
ylabel("Temperature");
legend("Valeurs reelles","Modèle");
plot(t,tMoy, 'k');
text(370, tMoy, "Moyenne");
grid;