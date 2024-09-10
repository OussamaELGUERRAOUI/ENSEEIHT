close all
clear all

Fc = 7000; %Hz
Delta_F = 1000; %Hz
F0 = Fc - Delta_F; %Hz
F1 = Fc + Delta_F; %Hz
Ns = 300;
Fe = 48000; %Hz
Te = 1/Fe; %s
Ts = Ns*Te;
n_bit = 100;
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

S_NRZ = (1/4)*Ts*(sinc(pi*Freq*Ts)).^2 + 1/4*dirac1(Freq);
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
title('NRZ')



