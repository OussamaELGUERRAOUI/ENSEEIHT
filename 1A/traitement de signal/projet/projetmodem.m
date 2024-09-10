close all
clear all

F0 = 6000; %Hz
F1 = 2000; %Hz
Fe = 48000; %Hz 
Debit = 300;
Ns = Fe/Debit;
n_bit = 100;
Fe = 48000; %Hz
Te = 1/Fe; %s
Ts = Ns*Te;
temps = 0:Te:(Ns*n_bit-1)*Te;;
%% 3.1

%1

A = randi([0,1],1,n_bit);
NRZ = kron(A,ones(1,Ns));

%2

figure(1)
plot(temps,NRZ)
xlabel("Temps en 's'")
ylabel("Amplitude en 'V'")
title('NRZ')

%3
NRZ_T = fft(NRZ)

DSP_NRZ = (1/Ns)*abs(NRZ_T).^2;
Freq = linspace(-Fe/2, Fe/2, length(DSP_NRZ));
figure(2)
semilogy(Freq, fftshift(abs(DSP_NRZ)))
xlabel("Frequence en 'Hz'")
ylabel("Amplitude en 'V'")
title('Densite spectrale de NRZ')

%4
 y = zeros(size(DSP_NRZ));
 y(length((DSP_NRZ)/2)) = 1;
S_NRZ = (1/4)*Ts*(sinc(pi*Freq*Ts)).^2 + 1/4*y;
figure(3)
semilogy(Freq, fftshift(abs(DSP_NRZ)),"r")
xlabel("Frequence en 'Hz'")
ylabel("Amplitude en 'V'")
title('Densite spectrale de NRZ')
hold on
semilogy(Freq, fftshift(abs(S_NRZ)),"b")

%% 3.2

%1
phi0 = rand*2*pi;
phi1 = rand*2*pi;
s0 = cos(2*pi*F0*temps + phi0);
s1 = cos(2*pi*F1*temps + phi1);
x = (1-NRZ).*s0 + NRZ.*s1;

%2
figure(4)
plot(temps,x)
xlabel("Temps en 's'")
ylabel("Amplitude en 'V'")
title('le signal x')

%3 Voir rapport

%4
X = fft(x)
DSP_x = (1/Ns)*abs(X).^2;
Freq = linspace(-Fe/2, Fe/2, length(DSP_x));
figure(5)
semilogy(Freq, fftshift(abs(DSP_x)))
xlabel("Frequence en 'Hz'")
ylabel("Amplitude en 'V'")
title('Densite spectrale de x')

%% 4

SNR_DB = 50;
Px = mean(abs(x).^2);
Pb = Px / (10^(SNR_DB/10)); %Puissance du bruit
n_echantillons = randn(1,length(x));
Bruit_Gaussien = sqrt(Pb)*n_echantillons; % signal du bruit gaussien
x1 = x + Bruit_Gaussien; % nouveau signal

figure(6) % figure dans une echelle temporelle
plot(temps,x1)
xlabel("Temps en 's'")
ylabel("Amplitude en 'V'")
title('le signal x1')
X1 = fft(x1)
DSP_x1 = (1/Ns)*abs(X1).^2;
Freq = linspace(-Fe/2, Fe/2, length(DSP_x1));
figure(7) % figure de la densite spectrale de x1
semilogy(Freq, fftshift(abs(DSP_x1)))
xlabel("Frequence en 'Hz'")
ylabel("Amplitude en 'V'")
title('Densite spectrale de x1')

%% synthése de filtrage
%reponse impulsionnelle
fc = (F0+F1)/2;
N = 30 ;
k = -N : N ; 
f_tilde = fc/Fe;
signal_filtre_PB = 2*f_tilde*sinc(2*f_tilde*k);
temps = -N*Te : Te : N*Te; 
figure(8)
subplot(211)
plot( temps , signal_filtre_PB );
xlabel('temps en s')
ylabel('Morceau de la trace impulsionnelle idéale')
title('Réponse impulsionnelle du filtre passe bas')

% reponse en frequence 


fft_filtre_PB = fftshift(fft(signal_filtre_PB)) ;  
F1 = -Fe/2 : Fe/(length(fft_filtre_PB)-1) : Fe/2 ; 
subplot(212)
plot( F1 , abs(fft_filtre_PB));
title('Tracé de la réponse en fréquence du filtre PB')
xlabel('Fréquences en Hz ')
ylabel('Réponse en fréquence')
%% DSP et Filtre passe bas en meme graphe
figure(9)
X1 = fftshift(fft(x1))
DSP_x1 = (1/Ns)*abs(X1).^2;
Freq = linspace(-Fe/2, Fe/2, length(DSP_x1));
plot(Freq, DSP_x1)
hold on;


k = -N : N ; 
f_tilde = fc/Fe;
signal_filtre_PB = 2*f_tilde*sinc(2*f_tilde*k)
fft_filtre_PB = fftshift(fft(signal_filtre_PB)) ;  
F1 = -Fe/2 : Fe/(length(fft_filtre_PB)-1) : Fe/2 ;
plot( F1 , abs(fft_filtre_PB));
hold off ;
title('Superposition du filtre passe-bas de la DSP du signal modulé')
xlabel('Fréquence ( en Hz )')
ylabel('Réponse en fréquence')
legend('Densité spectrale du signal modulé','Réponse en fréquence du filtre passe-bas')


%% 5.2 synthése filtre passe haut
%Réponse impulsionnelle

signal_filtre_PH = dirac1(k*Te)-signal_filtre_PB;
temps = -N*Te : Te : N*Te; 

figure(10)
subplot(211)

plot( temps , signal_filtre_PH);
title('Tracé de la réponse impulsionnelle du fitre PH')
xlabel('temps en s ')
ylabel('Réponse impulsionnelle')

%Réponse en fréquence
fft_filtre_PH = fftshift(fft(signal_filtre_PH))
F2 = -Fe/2 : Fe/(length(fft_filtre_PH) - 1) : Fe/2
   
subplot(212)
plot(F2,abs(fft_filtre_PH))
xlabel('Fréquences en Hz ')
ylabel('Réponse en fréquence')
title('Tracé de la réponse en fréquence du filtre PH')

figure





%% filtrage 
%filtre_passe_bas = conv(x1,signal_filtre_PB,'same')
signal_filtre_PH = dirac1(k*Te)-signal_filtre_PB;
filtre_passe_bas = filter(signal_filtre_PB,1,x1)
filtre_passe_haut = conv(x1,signal_filtre_PH,'same');
Temps = 0 : Te :(length(filtre_passe_bas) - 1)*Te
figure
plot(Temps,filtre_passe_bas)
xlabel('Temps en s')
ylabel('Signal x après filtrage')
title('Tracé du signal x après filtrage passe bas')

 figure
 plot(Temps,filtre_passe_haut)
 xlabel('Temps en s')
 ylabel('Signal x après filtrage')
 title('Tracé du signal x après filtrage passe haut')


fft_filtre_passe_haut = fft(filtre_passe_haut)
fft_filtre_passe_bas = fft(filtre_passe_bas)
F3 = 0 : Fe : (length(filtre_passe_haut)-1)*Fe

figure
plot(F3,abs(fft_filtre_passe_bas))
hold on;




xlabel('frequence en HZ')
ylabel('Signal x après filtrage')
title('Tracé du signal x après filtrage passe bas')
figure
plot(F3,abs(fft_filtre_passe_haut))
xlabel('frequence en hz')
ylabel('Signal x après filtrage')
title('Tracé du signal x après filtrage passe haut')

%% detection d'énergie

X = reshape(filtre_passe_bas,Ns,length(filtre_passe_bas)/Ns);

E = X.*X;
Energie = sum(E);

K = (min(Energie) + max(Energie))/2;
bits = (Energie > K);
error_bits = sum(bits)/length(bits) 

%modification du démolateur
fc = (F0+F1)/2;
N = 30 ;
k = -N : N ; 
f_tildem = fc/Fe;
signal_filtre_PBm = 2*(fc/Fe)*sinc(2*f_tildem*k);
temps = -N*Te : Te : N*Te; 
figure

plot( temps , signal_filtre_PBm );
xlabel('temps en s')
ylabel('Morceau de la trace impulsionnelle idéale')
title('Réponse impulsionnelle du filtre passe bas')
filtre_passe_basm = filter(signal_filtre_PBm,1,x)

Xm = reshape(filtre_passe_basm,Ns,length(filtre_passe_basm)/Ns);

Em = Xm.*Xm;
Energiem = sum(Em);

K = (min(Energiem) + max(Energiem))/2;
bitsm = (Energiem > K);
error_bitsm = sum(bitsm)/length(bitsm)












