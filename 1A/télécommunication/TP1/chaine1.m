%% Etude de l'impact du bruit et du filtrage adapté, notion d'efficacité en puissance

clear;
close all;
clc;

% Les paramètres

Fe = 24000; % Fréquence d'échantillonnage
Rb = 3000; % Débit binaire
Tb = 1/Rb; % Période d'échantillonnage
Te = 1/Fe; % Période d'échantillonnage
N = 100; % Nombre de bits
Rs = 1/Tb; % Fréquence de symbole
bits = randi([0 1],1,N); % Génération de N bits aléatoires
Ts = 1/Rs; % Période de symbole
Ns = Ts/Te; % Nombre d'échantillons par symbole
M = 2; % Nombre de symboles

%% Modulation

% Mapping
symboles = 2*bits-1;

% Sur-échantillonnage
signal_sur_echantillonne = kron(symboles,[1 zeros(1,Ns-1)]);

% Filtrage
h1 = ones(1,Ns);
x = filter(h1,1,signal_sur_echantillonne);
%% canal de propagation
hc = dirac(Ns)


%% Démodulation

% Filtre de réception rectangulaire de durée égale à la durée d'un symbole et de hauteur égale à 1
hr = ones(1,Ns);
z1 = filter(hr,1,x);
t = 0:Te:(length(z1)-1)*Te;

% Le tracé de z
figure;
plot(t,z1);
title('Signal en sortie du filtre de réception');
xlabel('Temps (s)');
ylabel('Amplitude');
axis([0 N*Tb -10 10]);
grid on;

% Le diagramme de l'oeil
figure;
plot(reshape(z1,Ns,length(z1)/Ns));
title("diagramme de l'oeil");

% Echantillonnage du signal
signal_echantillonne = z1(Ns:Ns:end);

% Decision sur les symboles
decision1 = sign(signal_echantillonne); 
symboles_estimes = (decision1>0);

TEB = sum(symboles_estimes~=bits)/N;
disp(['TES = ',num2str(TEB)]);

%% Chaine avec bruit

% Ajout du bruit

% Puissance du signal avant le bruit
Ps = mean(x.^2);

%Energie binaire
Eb = Ps/Ns;

% Puissance du bruit
N0 = 0.1;
sigma2 = (Ns*Ps)/2*log2(M)*(Eb/N0);

% Bruit gaussien
bruit = sqrt(sigma2)*randn(1,length(x));

% Signal bruité
y = x + bruit;

% Le tracé de y
figure;
plot(t,y);
title('Signal bruité');
xlabel('Temps (s)');
ylabel('Amplitude');
axis([0 N*Tb -20 20]);
grid on;

% Réponse impulsionnelle du filtre de réception
hr2 = ones(1,Ns);
z2 = filter(hr2,1,y);

% Le tracé de z2
figure;
plot(t,z2);
title('Signal en sortie du filtre de réception');
xlabel('Temps (s)');
ylabel('Amplitude');
axis([0 N*Tb -50 50]);
grid on;

% Le diagramme de l'oeil
figure;
plot(reshape(z2,Ns,length(z2)/Ns));
title("diagramme de l'oeil");

% Echantillonnage du signal
signal_echantillonne2 = z2(Ns:Ns:length(z2));

% Decision sur les symboles
decision2 = sign(signal_echantillonne2)
symboles_estimes2 = (decision2>0);
TEB2 = sum(symboles_estimes2~=bits)/N;
disp(['TES2 = ',num2str(TEB2)]);

% Taux d'erreur binaire pour 0 < TEB < 8
TEB3 = zeros(1,8);
hr3 = ones(1,Ns);
for i = 1:8
    sigma2 = (Ns*Ps)/(2*i);
    bruit = sqrt(sigma2)*randn(1,length(x));
    y = x + bruit;
    z3 = filter(hr3,1,y);
    signal_echantillonne3 = z3(Ns:Ns:end);
    decision3 = sign(signal_echantillonne3)
    bits_estimes3 = (signal_echantillonne3>0);
    TEB3(i) = sum(bits_estimes3~=bits)/N;
end
figure;
plot(1:8,TEB3);
title('TEB en fonction de sigma2');
xlabel('sigma2');
ylabel('TEB');
grid on;




