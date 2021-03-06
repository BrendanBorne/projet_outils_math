clear all;
close all;

#Importation des donn�es
buch=load("Bucherons.txt");
n_tab=buch(:,2);
j_tab=buch(:,1);

n=n_tab(1);
nmax=max(n_tab);
res=[n];

tmax=max(j_tab);
dt=7;
t=1;
t_tab=[t];

flux1=n_tab.*((4.1*10^-3)/7);
flux2=n_tab.*(5.2*10^-4);

K=0.5;
#Calcul
for i=t:1:30
  n=nmax*(1-exp(-K*(i-0)));
  res=[res;n];
  t=t+dt;
  t_tab=[t_tab;t];
endfor

#Affichage
figure(1);
hold on;
plot(j_tab,n_tab);
plot(t_tab,res);
#plot(j_tab,flux1);
#plot(j_tab,flux2);
title("Evolution du nombre de bucherons au cours du temps");
xlabel("Jours");
ylabel("Bucherons");
legend("Valeurs r�elles","Mod�le de VB");
grid;