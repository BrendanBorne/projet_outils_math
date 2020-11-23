clear all;
close all;

#Importation des données
buch=load("Bucherons.txt");
n=buch(:,2);
j=buch(:,1);

n0=n(1);
nmax=max(n);

tmax=max(j);
dt=7;
t=1;
t_tab=[t];

flux1=n.*((4.1*10^-3)/7);
flux2=n.*(5.2*10^-4);

#Calcul
for i=t:dt:tmax
  t=t+dt;
  t_tab=[tab_tab;t];
endfor

#Affichage
figure(1);
hold on;
plot(j,n);
#plot(j,flux1);
#plot(j,flux2);
title("Evolution du nombre de bucherons au cours du temps");
xlabel("Jours");
ylabel("Bucherons");
grid;