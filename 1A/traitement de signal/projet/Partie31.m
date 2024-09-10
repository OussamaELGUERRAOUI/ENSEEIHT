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
temps = 0:Te:(Ns*n_bit-1)*Te;
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

DSP_NRZ = pwelch(NRZ,[],[],[],Fe,'twosided');
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

DSP_x = pwelch(x,[],[],[],Fe,'twosided');
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

DSP_x1 = pwelch(x1,[],[],[],Fe,'twosided');
Freq = linspace(-Fe/2, Fe/2, length(DSP_x1));
figure(7) % figure de la densite spectrale de x1
semilogy(Freq, fftshift(abs(DSP_x1)))
xlabel("Frequence en 'Hz'")
ylabel("Amplitude en 'V'")
title('Densite spectrale de x1')

%% 5

fc = (F0+F1)/2;
ordre2 = 61;

t_ordre2  = -(ordre2-1)/2*Te:Te:(ordre2-1)/2*Te; % % [-30Te,-4Te,...,4Te,30Te]
h2 = 2*fc*sinc(2*pi*fc*t_ordre2);
figure(8)
plot(t_ordre2,h2)
xlabel("temps en 's'")
ylabel("gain")
title("Reponse impulsionnelle ordre = 61")





