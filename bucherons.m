clear all;
close all;

#Importation des données
buch=load("Bucherons.txt");
n=buch(:,2);
j=buch(:,1);

#Affichage
figure(1);
plot(j,n);
title("Evolution du nombre de bucherons au cours du temps");
xlabel("Jours");
ylabel("Bucherons");
grid;