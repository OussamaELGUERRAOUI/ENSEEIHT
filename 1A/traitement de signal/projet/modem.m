clear all % efface toutes les variables du workspace
close all % ferme toutes les figures ouvertes

F0 = 6000; % Hz, fréquence de la porteuse 0
F1 = 2000; % Hz, fréquence de la porteuse 1
Fe = 48000; % Hz, fréquence d'échantillonnage
Debit = 300; % bauds, débit du signal NRZ
Ns = Fe/Debit; % nombre d'échantillons par bit
n_bit = 100; % nombre de bits du signal NRZ
Te = 1/Fe; % s, intervalle de temps entre chaque échantillon
Ts = Ns*Te; % s, intervalle de temps entre chaque bit
temps = 0:Te:(Ns*n_bit-1)*Te; % vecteur des instants de temps

%% Génération et affichage du signal NRZ

% Génération du signal NRZ
A = randi([0,1],1,n_bit); % génère un vecteur de bits aléatoires de longueur n_bit
NRZ = kron(A,ones(1,Ns)); % étend chaque bit sur Ns échantillons consécutifs

% Affichage du signal NRZ dans une échelle temporelle
figure(1)
plot(temps,NRZ)
xlabel("Temps en s")
ylabel("Amplitude en V")
title('Tracé du signal NRZ')

% Calcul et affichage de la densité spectrale du signal NRZ
NRZ_T = fft(NRZ); % transformée de Fourier du signal NRZ
DSP_NRZ = (1/Ns)*abs(NRZ_T).^2; % densité spectrale du signal NRZ
Freq = linspace(-Fe/2, Fe/2, length(DSP_NRZ)); % vecteur des fréquences du spectre du signal NRZ
figure(2)
subplot(211)
semilogy(Freq, fftshift(abs(DSP_NRZ))) % affiche la densité spectrale du signal NRZ sur une échelle logarithmique
xlabel("Frequence en Hz")
ylabel("Amplitude en 'V'")
title('Tracé de la densite spectrale de NRZ')

% Calcul et affichage de la densité spectrale du filtre ideal NRZ
y = zeros(size(DSP_NRZ)); % vecteur de zéros de même taille que DSP_NRZ
y(length((DSP_NRZ)/2)) = 1; % met à 1 le coefficient correspondant à la fréquence 0
S_NRZ = (1/4)*Ts*(sinc(pi*Freq*Ts)).^2 + 1/4*y; % densité spectrale du filtre idéal NRZ
subplot(212)
semilogy(Freq, fftshift(abs(DSP_NRZ)),"r") % affiche la densité spectrale du signal NRZ sur une échelle logarithmique
xlabel("Frequence en Hz")
ylabel("Amplitude en V")
title('Tracé de la densite spectrale ideal de NRZ')
hold on % maintient la figure 3 active pour ajouter des courbes
semilogy(Freq, fftshift(abs(S_NRZ)),"b") % affiche la densité spectrale du filtre idéal NRZ sur une échelle logarithmique

%% Modulation du signal NRZ

% Génération des porteuses
phi0 = rand*2*pi; % phase aléatoire de la porteuse 0
phi1 = rand*2*pi; % phase aléatoire de la porteuse 1
s0 = cos(2*pi*F0*temps + phi0); % porteuse 0
s1 = cos(2*pi*F1*temps + phi1); % porteuse 1

% Modulation du signal NRZ
x = (1-NRZ).*s0 + NRZ.*s1; % signal modulé

% Affichage du signal modulé dans une échelle temporelle
figure(3)
subplot(211)
plot(temps,x)
xlabel("Temps en s")
ylabel("Amplitude en V")
title('Tracé du signal x')

% Calcul et affichage de la densité spectrale du signal modulé
X = fft(x); % transformée de Fourier du signal modulé
DSP_x = (1/Ns)*abs(X).^2; % densité spectrale du signal modulé
Freq = linspace(-Fe/2, Fe/2, length(DSP_x)); % vecteur des fréquences du spectre du signal modulé
subplot(212)
semilogy(Freq, fftshift(abs(DSP_x))) % affiche la densité spectrale du signal modulé sur une échelle logarithmique
xlabel("Frequence en Hz")
ylabel("Amplitude")
title('Densite spectrale de x')

%% Ajout du bruit au signal modulé
SNR_DB = 50; % rapport signal sur bruit en dB
Px = mean(abs(x).^2); % puissance du signal modulé
Pb = Px / (10^(SNR_DB/10)); % puissance du bruit
n_echantillons = randn(1,length(x)); % génère un vecteur de nombres aléatoires suivant une loi normale
Bruit_Gaussien = sqrt(Pb)*n_echantillons; % signal du bruit gaussien
x1 = x + Bruit_Gaussien; % signal bruité

% Affichage du signal bruité dans une échelle temporelle
figure(4)
subplot(211)
plot(temps,x1)
xlabel("Temps en s")
ylabel("Amplitude en V")
title('Tracé du signal x1')

% Calcul et affichage de la densité spectrale du signal bruité
X1 = fft(x1); % transformée de Fourier du signal bruité
DSP_x1 = (1/Ns)*abs(X1).^2; % densité spectrale du signal bruité
Freq = linspace(-Fe/2, Fe/2, length(DSP_x1)); % vecteur des fréquences du spectre du signal bruité
subplot(212)
semilogy(Freq, fftshift(abs(DSP_x1))) % affiche la densité spectrale du signal bruité sur une échelle logarithmique
xlabel("Frequence en 'Hz'")
ylabel("Amplitude en 'V'")
title('Densite spectrale de x1')

%% Réponse impulsionnelle et en fréquence du filtre passe bas
fc = (F0+F1)/2; % Fréquence c
N = 30; % Nombre de coefficients de filtrage
k = -N : N; % Vecteur des indices
f_tilde = fc/Fe; % Fréquence normalisée
signal_filtre_PB = 2*f_tilde*sinc(2*f_tilde*k); % Réponse impulsionnelle du filtre passe bas

% Tracé de la réponse impulsionnelle du filtre passe bas
figure(5)
subplot(211)
plot(k, signal_filtre_PB)
xlabel('temps en s')
ylabel('Morceau de la trace impulsionnelle idéale')
title('Réponse impulsionnelle du filtre passe bas')

% Tracé de la réponse en fréquence du filtre passe bas
fft_filtre_PB = fftshift(fft(signal_filtre_PB));
FPB = linspace(-Fe/2,Fe/2,length(fft_filtre_PB));
subplot(212)
semilogy(FPB, abs(fft_filtre_PB))
title('Tracé de la réponse en fréquence du filtre PB')
xlabel('Fréquences en Hz ')
ylabel('Réponse en fréquence')

%% Réponse impulsionnelle et en fréquence du filtre passe haut
signal_filtre_PH = dirac1(k*Te) - signal_filtre_PB; % Réponse impulsionnelle du filtre passe haut

% Tracé de la réponse impulsionnelle du filtre passe haut
figure(6)
subplot(211)
plot(k, signal_filtre_PH)
title('Tracé de la réponse impulsionnelle du fitre PH')
xlabel('temps en s ')
ylabel('Réponse impulsionnelle')

% Tracé de la réponse en fréquence du filtre passe haut
fft_filtre_PH = fftshift(fft(signal_filtre_PH));
subplot(212)
plot(FPB, abs(fft_filtre_PH))
xlabel('Fréquences en Hz ')
ylabel('Réponse en fréquence')
title('Tracé de la réponse en fréquence du filtre PH')

% Filtrage du signal x avec les filtres passe bas et passe haut
filtre_passe_bas = filter(signal_filtre_PB,1,x1); % Filtre passe bas
filtre_passe_haut = conv(x, signal_filtre_PH, 'same'); % Filtre passe haut
Temps = 0 : Te : (length(filtre_passe_bas) - 1)*Te; % Vecteur des temps

% Tracé du signal x après filtrage passe bas
figure(7)
subplot(211)
plot(Temps, filtre_passe_bas)
xlabel('Temps en s')
ylabel('Signal x après filtrage')
title('Tracé du signal x après filtrage passe bas')

% Tracé du signal x après filtrage passe haut
subplot(212)
plot(Temps, filtre_passe_haut)
xlabel('Temps en s')
ylabel('Signal x après filtrage')
title('Tracé du signal x après filtrage passe haut')

% Tracé de la transformée de Fourier du signal x après filtrage passe bas et passe haut
fft_filtre_passe_haut = fft(filtre_passe_haut);
fft_filtre_passe_bas = fft(filtre_passe_bas);
F3 = 0 : Fe : (length(filtre_passe_haut)-1)*Fe;

% Tracé de la transformée de Fourier du signal x après filtrage passe bas
figure(8)
subplot(211)
plot(F3, abs(fft_filtre_passe_bas))
xlabel('frequence en HZ')
ylabel('Signal x après filtrage')
title('Tracé du signal x après filtrage passe bas')

% Tracé de la transformée de Fourier du signal x après filtrage passe haut
subplot(212)
plot(F3, abs(fft_filtre_passe_haut))
xlabel('frequence en hz')
ylabel('Signal x après filtrage')
title('Tracé du signal x après filtrage passe haut')




%% Détection d'énergie

X = reshape(filtre_passe_bas, Ns, n_bit);

Energie = sum(X.^2);

K = (min(Energie) + max(Energie))/2; % seuil deteminé
bits_pb = (Energie > K); % bits détectés à partir du signal filtré passe-bas



J = (bits_pb ~= A);

error_bits = sum(J)/length(J); % Calcul du taux d'erreur binaire (BER)


% Affichage des résultats
fprintf("Taux d'erreur binaire du signal filtré passe-bas : %.3f\n", error_bits);


%% 5.6
%- Il est possible que les résultats ne soient pas les mêmes lorsque le nombre 
%de coefficients des filtres est augmenté de 201 car cela peut avoir un 
%impact sur le comportement du filtre et sur sa réponse en fréquence. 
%En augmentant le nombre de coefficients, on peut obtenir une réponse en 
%fréquence plus précise et ainsi mieux filtrer les fréquences indésirables. 
%Cependant, cela peut aussi entraîner un temps de calcul plus long et une 
%complexité accrue du filtre.
%- uriliser la f_tilde = fc/fe/N

% en augmentant l'ordre du filtrev à 201







