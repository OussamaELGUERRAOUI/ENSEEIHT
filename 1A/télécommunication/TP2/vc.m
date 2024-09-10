% Télécommunication : Etude des chaines de transmission sur fréquence porteuse 
% Auteurs : JMAL Yessine et GONTHIER Priscilia
% Groupe : 1SN-M

clear
close all

%# Données du problème :
Fe = 10000; % Fréquence d'échantillonnage
Te = 1/Fe; % Période d'échantillonnage 
Rb = 2000; % Débit binaire
Tb = 1/Rb; % Période binaire
fp = 2000; % Fréquence porteuse
roll_off = 0.35; % Roll-off  du filtre : paramètre qui fixe la largeur de bande

%# Information binaire à transmettre :
Nb_bits = 1000; % Nombre de bits générés
bits = randi([0,1],1,Nb_bits); % Message de Nb_bits bits

%% Implantation de la chaine sur fréquence porteuse
%## Données spécifiques à la modulation en bande de base :
M = 4; % Ordre de modulation
l=log2(M); % Nombre de bits codants par symbole

%## Mapping de Gray : 00->-1-i, 01->-1+i, 11->1+i, 10->1-i
Symboles2 = reshape(bits,2,Nb_bits/2)';
Symboles3 = Symboles2;
Symboles3(:,1) = Symboles2(:,2);
Symboles3(:,2) = Symboles2(:,1);
Symboles2 = bi2de(Symboles3);

symboles2_re = -1*(Symboles2 == 0 | Symboles2 == 1) + 1*(Symboles2 == 2 | Symboles2 == 3);
symboles2_im = -1*(Symboles2 == 0 | Symboles2 == 2) + 1*(Symboles2 == 1 | Symboles2 == 3);
symboles2_finaux = symboles2_re + 1i*symboles2_im; % Symboles à transmettre

Rs1 = Rb/log2(M); % Débit symbole
Ts1 = 1/Rs1; % Période Symbole
Ns1 = Ts1/Te; % Nombre de bit par symbole
long = (Nb_bits * Ns1)/l; % Longueur du signal
T = long *Te; % Durée du signal;

%# Tracé de la constellation :
figure("Name", "Constellation QPSK");
plot(symboles2_finaux,"*");
xlabel("a_k");
ylabel("b_k");
title("Constellation QPSK");
grid on;

%## Suréchantillonnage :
Suite_diracs = kron(symboles2_finaux.', [1 zeros(1,Ns1-1)]); % Suite de Diracs pondérés par les symboles

%## Filtrage de mise en forme :
ord = 16; % Ordre du filtre
h =  rcosdesign(roll_off,ord, Ns1); % Réponse impulsionnelle du filtre (en racine de cosinus surelévé)
x1 = filter(h,1,Suite_diracs); % Signal transmis

%# Tracé des signaux :
t = [0:Te:T - Te];
%## Signal en phase :
figure("Name", "Signal en phase et en quadrature");
subplot(2,1,1);
plot(t, real(x1));
xlabel("t (s)");
ylabel("I(t)");
title("Signal en phase");
grid on;

%## Signal en quadrature :
subplot(2,1,2);
plot(t, imag(x1));
xlabel("t (s)");
ylabel("Q(t)");
title("Signal en quadrature");
grid on;

%## Transposition en fréquence porteuse :
x1_fre = real(x1 .* exp( 1i * 2 * pi * fp * t));

figure("Name", "Signal après modulation en fréquence");
plot(t, real(x1_fre));
xlabel("t (s)");
ylabel("x(t)");
title("Signal après modulation en fréquence");
grid on;

%## Calul et affichage de la DSP :
dsp_x1 = fft(xcorr(x1_fre));

F = linspace(-Fe/2, Fe/2, length(dsp_x1));

figure ("Name", "DSP");
semilogy(F,fftshift(abs(dsp_x1)));
xlabel("Fréquence (Hz)");
ylabel("module de la DSP");
title("Densité Spectrale de Puissance du signal après filtrage")
grid on;

%## Démodulation sans bruit :
%### Retour en bande de base
% Partie cos
x1_cos = x1_fre .* cos(2 * pi * fp * t);
DSP_x1_cos= fft(xcorr(x1_cos)); %DSP de x1
figure ("Name", "DSP_cos");
%plot(F,fftshift(abs(DSP_x1_cos)));
semilogy(F, fftshift(abs(DSP_x1_cos)));
xlabel("f (Hz)");
ylabel("DSP");
title("Densité Spectrale de Puissance ");
grid on;

% A partir de la figure on choisit une frequence de coupure du filtre fc =
% 2000 Hz
fc_pb_x1tild = 2000; % Fréquence de coupure 
fc_pb_x1tild = fc_pb_x1tild/Fe; % Normalisation de la fréquence de coupure 
Ord_1 = 201; % Ordre du filtre passe-bas (doit etre impair car on calcule (Ord_1-1)/2 qui doit etre entier)
Rif_pb_x1tild = 2 * fc_pb_x1tild * sinc(2 * fc_pb_x1tild * [-(Ord_1-1)/2:(Ord_1-1)/2]); % Réponse impulsionelle du filtre passe-bas

% Filtrage passe-bas
x1filtre = filter(Rif_pb_x1tild,1,x1_cos); % Filtrer le signal
DSP_x1_cos_filtre= fft(xcorr(x1filtre)); % DSP de x1
figure ("Name", "x1_cos_filtré");
plot(linspace(-Fe/2, Fe/2, length(DSP_x1_cos_filtre)),fftshift(abs(DSP_x1_cos_filtre)));
xlabel("Fréquence (Hz)");
ylabel("Module de la DSP");
title("DSP du signal apres filtrage")

% Partie sin 
x1_sin = x1_fre .* sin(2 * pi * fp * t);
DSP_x1_sin= fft(xcorr(x1_sin)); %DSP de x1
figure ("Name", "x1_sin");
%plot(F,fftshift(abs(DSP_x1_sin)));
semilogy(F, fftshift(abs(DSP_x1_sin)));
xlabel("f (Hz)");
ylabel("DSP");
title("Densité Spectrale de Puissance");
grid on;

% A partir de la figure on choisit une frequence de coupure du filtre fc =
% 2000 Hz
fc_pb_x1tild = 2000; % Fréquence de coupure 
fc_pb_x1tild = fc_pb_x1tild/Fe; % Normalisation de la fréquence de coupure 
Ord_1 = 201; % Ordre du filtre passe-bas (doit etre impair car on calcule Ord_1-1)/2 qui doit etre entier)
Rif_pb_x1tild = 2*fc_pb_x1tild*sinc(2*fc_pb_x1tild*[-(Ord_1-1)/2:(Ord_1-1)/2]); % Réponse impulsionelle du filtre passe-bas

% Filtrage passe-bas
x1_sin_filtre = filter(Rif_pb_x1tild,1,x1_sin); % Filtrer le signal
DSP_x1_sin_filtre= fft(xcorr(x1_sin_filtre)); % DSP de x1
figure ("Name", "DSPx1_sin_filtré");
plot(linspace(-Fe/2, Fe/2, length(DSP_x1_sin_filtre)),fftshift(abs(DSP_x1_sin_filtre)));
xlabel("Fréquence (Hz)");
ylabel("module de la DSP");
title("DSP du signal apres filtrage")

%## Réception et filtrage :
x_bb = x1filtre - 1i * x1_sin_filtre;

%filtre de reception 
h_r =  fliplr(h); % Réponse impulsionnelle du filtre 
z = filter(h_r,1,x_bb);

%# Diagrame de l'oeil :
z_aff = reshape(real(z),Ns1,length(z)/Ns1);
figure("Name", "diagramme de l'oeil");
plot(z_aff);
xlabel("Indice");
ylabel("z (v)");
title("Diagramme de l'oeil en sortie du filtre de réception");
grid on;


% Choix de n0 à partir du diagramme de l'oeil
n0 = 1 ;

% Echantillonage du signal en sortie du filtre de réception 
z_echant = z(n0:Ns1:end);

% Prise de décision et demapping
Bits_recuperes = zeros(1,Nb_bits);
Bits_recuperes(1:2:end) = 0* (real(z_echant)<=0) + 1 *(real(z_echant)>0);
Bits_recuperes(2:2:end) = 0* (imag(z_echant)<=0) + 1 *(imag(z_echant)>0);

% Calcul du Taux d'erreur binaire
retard = 2* ord + ((Ord_1-1)/Ns1);
erreur = abs(bits(1,1:Nb_bits-retard)-Bits_recuperes(1,retard+1:Nb_bits)); 
TEB1 = mean(erreur);


     