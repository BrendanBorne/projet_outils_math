clear all;
close all;

#Importation des donn�es
temp=load("Temp2011.txt");
tab=[temp(:,2)];

#Traitement des donn�es
tMoy=mean(tab)+273;
amp=max(tab)-min(tab)+273;

#Tableau t pour les donn�es import�es
t=[];
temp=[];
for i=1:2:365
  t=[t;i]; 
endfor

#Simulation de la temp�rature
tsim=[];
for i=1:365
  tsim=[tsim;i];
  calcul = tMoy + (amp/2 * sin(((2*pi)/365)*i+89.5));
  temp=[temp;calcul];
endfor

#Aper�u des donn�es
figure(1);
hold on;
plot(t,tab);
plot(tsim,temp);
title("Evolution de la temp�rature aux alentours de l'�tang de XFC.678.F9");
xlabel("Jours");
ylabel("Temperature");
legend("Valeurs r�elles","Simulation");
plot(t,tMoy, 'k');
text(370, tMoy, "Moyenne");
grid;