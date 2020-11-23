clear all;
close all;

#Importation des données
buch=load("Bucherons.txt");
n=buch(:,2);
j=buch(:,1);

n0=n(1);
nmax=max(n);

#Calcul


#Affichage
figure(1);
plot(j,n);
title("Evolution du nombre de bucherons au cours du temps");
xlabel("Jours");
ylabel("Bucherons");
grid;