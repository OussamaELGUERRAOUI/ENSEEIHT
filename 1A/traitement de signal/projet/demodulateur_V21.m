clear all;
close all;

F0 = 1180; % Hz, fréquence de la porteuse 0
F1 = 980; % Hz, fréquence de la porteuse 1
Fe = 48000; % Hz, fréquence d'échantillonnage
Debit = 300; % bauds, débit du signal NRZ
Ns = Fe/Debit; % nombre d'échantillons par bit
n_bit = 100; % nombre de bits du signal NRZ
Te = 1/Fe; % s, intervalle de temps entre chaque échantillon
Ts = Ns*Te; % s, intervalle de temps entre chaque bit
temps = 0:Te:(Ns*n_bit-1)*Te; % vecteur des instants de temps

% Génération du signal NRZ
A = randi([0,1],1,n_bit); % génère un vecteur de bits aléatoires de longueur n_bit
NRZ = kron(A,ones(1,Ns)); % étend chaque bit sur Ns échantillons consécutifs



phi0 = rand*2*pi; % phase aléatoire de la porteuse 0
phi1 = rand*2*pi; % phase aléatoire de la porteuse 1
s0 = cos(2*pi*F0*temps + phi0); % porteuse 0
s1 = cos(2*pi*F1*temps + phi1); % porteuse 1

% Modulation du signal NRZ
x = (1-NRZ).*s0 + NRZ.*s1; % signal modulé


SNR_DB =50; % rapport signal sur bruit en dB
Px = mean(abs(x).^2); % puissance du signal modulé
Pb = Px / (10^(SNR_DB/10)); % puissance du bruit
n_echantillons = randn(1,length(x)); % génère un vecteur de nombres aléatoires suivant une loi normale
Bruit_Gaussien = sqrt(Pb)*n_echantillons; % signal du bruit gaussien
x_br = x + Bruit_Gaussien; % signal bruité


%% Démodulateur de fréquence adapté à la norme V21

%6.1 Contexte de synchronisation idéale

%6.1.1 calcule les intégrales du récepteur
f1 = @(temps) cos((2*pi*F0).*temps + phi0).^2 ;
int_f1 = integral(f1,0,Ts); 
%= 0.00169

f2 =@(temps)  cos((2*pi*F1).*temps + phi1).^2 ;
int_f2 = integral(f2,0,Ts);
%= 0.00172


f3 = @(temps) cos((2*pi*F0).*temps + phi0).*cos((2*pi*F1).*temps + phi1);
int_f3 = integral(f3,0,Ts);
%= -1.182678968722742e-04

% le détail du calcul sera sur le rapport


%6.1.2 l'implantation du démodulateur 

%avec bruit
x_br0 = reshape(x_br.*cos(2*pi*F0*temps + phi0),Ns,n_bit);
x_br1 = reshape(x_br.*cos(2*pi*F1*temps + phi1),Ns,n_bit);

int_xbr0 = trapz(x_br0);
int_xbr1 = trapz(x_br1);

H_bruit = int_xbr1 - int_xbr0;
Bits_retrouves_bruit = H_bruit > 0;

error_bruit = Bits_retrouves_bruit ~= A;
taux_error_bruit = sum(error_bruit)/n_bit;
fprintf("Taux d'erreur binaire du signal bruité : %.3f\n", taux_error_bruit);


%sans bruit

x0 = reshape(x.*cos(2*pi*F0*temps + phi0),Ns,n_bit);
x1 = reshape(x.*cos(2*pi*F1*temps + phi1),Ns,n_bit);

int_x0 = trapz(x0);
int_x1 = trapz(x1);

H_sans_bruit = int_xbr1 - int_xbr0;

Bits_retrouves_sans_bruit = H_sans_bruit > 0;

error_sans_bruit = Bits_retrouves_sans_bruit ~= A
taux_error_sans_bruit = sum(error_sans_bruit)/n_bit;

fprintf("Taux d'erreur binaire du signal sans bruit : %.3f\n",taux_error_sans_bruit);


