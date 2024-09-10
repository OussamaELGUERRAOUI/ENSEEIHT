
clear;
close all;
clc;

% Les paramètres

Fe = 24000; % Fréquence d'échantillonnage
Rb = 3000; % Débit binaire
Tb = 1/Rb; % Période d'échantillonnage
Te = 1/Fe; % Période d'échantillonnage
N = 10000; % Nombre de bits
k = 2; % Nombre de bits par symbole
M = 2^k; % Ordre de modulation
Rs = 1/(log2(M)*Tb); % Fréquence de symbole
Ts = 1/Rs; % Période de symbole
Ns = Ts/Te; % Nombre d'échantillons par symbole
Fp = 2000; %fréquence porteuse
alpha = 0.35;


bits = randi([0 1],1,N); % Génération de N bits aléatoires

%% modulation bande de base avec symboles complexes sans bruit



% mapping

%symbole =[1+i, 1-i, -1+i, -1-i ]
a = -1 + 2*bits(1:2:N);
b = -1 + 2*bits(2:2:N);
symboles = a + b*i ;
figure;
plot(a);

% Sur-échantillonnage

signal_sur_echantillonne = kron(symboles,[1, zeros(1,Ns-1)]);
figure;
plot (real(signal_sur_echantillonne));

% Filtre de mise en forme

L = length(signal_sur_echantillonne)/Ns;
h = rcosdesign(alpha, L, Ns, 'sqrt');

ordre = length(h);
    
% Le décalage introduit par le filtre
decalage = floor((ordre-1)/2);

% Ajouter un padding de zeros à la sortie 
xe =filter(h,1, [signal_sur_echantillonne zeros(1, decalage)]);

% signal générer sur la voie en phase
I = real(xe(decalage +1:end));


% signal générer sur la voie en phase
Q = imag(xe(decalage +1:end));



%% transposition de fréquence
t = Te:Te:length(xe(decalage+1:end))*Te;
x_comp = xe(decalage+1:end).*exp(1i*2*pi*t.*Fp);
x= real(x_comp);

H = fftshift(fft(x),length(xe));

figure;
semilogy(abs(H));

DSPe = pwelch(xe, [], [], [], Fe, 'twosided');
DSP1 = pwelch(x, [], [], [], Fe, 'twosided');
f = -(Fe/2)*length(DSP1):Fe:(Fe/2)*length(DSP1) - Fe;
fe =0:Fe/length(DSPe):Fe-Fe/length(DSPe);
figure;

semilogy(fe, DSPe);
title('DSPe ');
xlabel('Fréquence (Hz)');
ylabel('DSP');
grid on;

figure;
plot(f, DSP1);
title('DSP1');
xlabel('Fréquence (Hz)');
ylabel('DSP');
grid on;


%


%% retour en bande base

T= Te: Te: Te*length(x);
xsin = x.*sin(2*pi*Fp*t);
xcos = x.*cos(2*pi*Fp*t);

y = xcos - 1i*xsin;

%% démodulation bande de base

% filtre de réciption

L = length(y)/Ns;
hr = rcosdesign(alpha, L, Ns, 'sqrt');

ordre = length(hr);
    
% Le décalage introduit par le filtre
decalage = floor((ordre-1)/2);

% Ajouter un padding de zeros à la sortie 
z =filter(hr,1, [y zeros(1, decalage)]);


z_dec = z(decalage +1: end);
figure; 
plot(real(z_dec));

DSPS = pwelch(z_dec, [], [], [], Fe, 'twosided');
fs = -(Fe/2)*length(DSPS) : Fe :(Fe/2)*length(DSPS) - Fe;




% echantillonage 

z_echan = z_dec(1:Ns:end);
figure;
plot(real(z_echan));

% demapping


bits_estime = zeros(1,N);
z_echr = real(z_echan);
z_echi = imag(z_echan);


bits_estime(1:2:end) = (z_echr > 0);
bits_estime(2:2:end) = (z_echi > 0);

TEB_sansbruit = sum(bits_estime ~= bits)/N;
 

%% modulation bande de base avec symboles complexes avec bruit

% mapping

%symbole =[1+i, 1-i, -1+i, -1-i ]
a = -1 + 2*bits(1:2:N);
b = -1 + 2*bits(2:2:N);
symboles = a + b*i ;
figure;
plot(a);

% Sur-échantillonnage

signal_sur_echantillonne = kron(symboles,[1, zeros(1,Ns-1)]);
figure;
plot (real(signal_sur_echantillonne));

% Filtre de mise en forme

L = 100;
h = rcosdesign(alpha, L, Ns, 'sqrt');

ordre = Ns*L;
    
% Le décalage introduit par le filtre
decalage = floor(ordre/2);

% Ajouter un padding de zeros à la sortie 
xe =filter(h,1, [signal_sur_echantillonne zeros(1, decalage)]);

% signal générer sur la voie en phase
I = real(xe(decalage +1:end));


% signal générer sur la voie en phase
Q = imag(xe(decalage +1:end));



%% transposition de fréquence
t = Te:Te:length(xe(decalage+1:end))*Te;
x_comp = xe(decalage+1:end).*exp(1i*2*pi*t.*Fp);
x= real(x_comp);

H = fftshift(fft(x),length(xe));

figure;
semilogy(abs(H));

DSPe = pwelch(xe, [], [], [], Fe, 'twosided');
DSP1 = pwelch(x, [], [], [], Fe, 'twosided');
f = -(Fe/2)*length(DSP1):Fe:(Fe/2)*length(DSP1) - Fe;
fe =0:Fe/length(DSPe):Fe-Fe/length(DSPe);
figure;

semilogy(fe, DSPe);
title('DSPe ');
xlabel('Fréquence (Hz)');
ylabel('DSP');
grid on;

figure;
plot(f, DSP1);
title('DSP1');
xlabel('Fréquence (Hz)');
ylabel('DSP');
grid on;


%% canal de transmission Réel passe-bande
for  i=1:7
     % Eb/N0 en dB
    EbN0dB = 10^((i-1)/10);

    % Calcul de la puissance du bruit
    sigma2 = (Ns*mean(x.^2))./(2*EbN0dB);

    % Bruit gaussien
    bruit = sqrt(sigma2)*randn(1, length(x));

    % Siganl bruité
    r = x + bruit;



%% retour en bande base

T= Te: Te: Te*length(x);
xsin = r.*sin(2*pi*Fp*t);
xcos = r.*cos(2*pi*Fp*t);

y = xcos - 1i*xsin;

%% démodulation bande de base

% filtre de réciption

L = 100;
hr = rcosdesign(alpha, L, Ns, 'sqrt');

ordre = L*Ns;
    
% Le décalage introduit par le filtre
decalage = floor(ordre/2);

% Ajouter un padding de zeros à la sortie 
z =filter(hr,1, [y zeros(1, decalage)]);


z_dec = z(decalage +1: end);





% echantillonage 

z_echan = z_dec(1:Ns:end);
figure;
plot(real(z_echan));

% demapping


bits_estime = zeros(1,N);
z_echr = real(z_echan);
z_echi = imag(z_echan);


bits_estime(1:2:end) = (z_echr > 0);
bits_estime(2:2:end) = (z_echi > 0);

%Taux d'erreur binaire
TEB_avecbruit(i) = sum(bits_estime ~= bits)/N;

% taux d'erreur theorique
TEB_theorique(i) = qfunc(sqrt(2*EbN0dB)*sin(pi/M));

fprintf('TEB avec bruit pour i = %d est %f\n', i, TEB_avecbruit(i));
fprintf('TEB avec bruit pour i = %d est %f\n', i, TEB_theorique(i));
end



% Tracé du TEB Estimé en fonction de Eb/N0
figure;
semilogy(0:6, TEB_avecbruit, 'r');
grid on;
title('TEB Estimé en fonction de Eb/N0 ');
xlabel('SNR (dB)');
ylabel('TEB');

% Tracé du TEB et du TEB théorique
figure;
semilogy(0:6, TEB_avecbruit, 'r');
hold on;
semilogy(0:6, TEB_theorique, 'b');
grid on;
title('TEB éstimé avec bruit et TEB théorique');
xlabel('SNR (dB)');
ylabel('TEB');
legend('TEB éstimé', 'TEB théorique');





   
















































