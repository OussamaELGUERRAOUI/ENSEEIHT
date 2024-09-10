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


%% 6.2 Gestion d'une erreur de synchronisation de phase porteuse

theta0 = rand*2*pi;
theta1 = rand*2*pi;



x_cos0 = reshape(x_br.*cos(2*pi*F0*temps + theta0),Ns,n_bit);
x_cos1 = reshape(x_br.*cos(2*pi*F1*temps + theta1),Ns,n_bit);
x_sin0 = reshape(x_br.*sin(2*pi*F0*temps + theta0),Ns,n_bit);
x_sin1 = reshape(x_br.*sin(2*pi*F1*temps + theta1),Ns,n_bit);

int_xcos0 = trapz(x_cos0);
int_xcos1 = trapz(x_cos1);
int_xsin0 = trapz(x_sin0);
int_xsin1 = trapz(x_sin1);

H = (int_xcos1.^2 + int_xsin1.^2 ) - (int_xcos0.^2 + int_xsin0.^2);

Bits_retrouves = H > 0;

error = (Bits_retrouves ~= A);

taux_error = sum(error)/n_bit;

fprintf("Taux d'erreur binaire du signal  : %.3f\n", taux_error);