%% Etude de l'impact du bruit et du filtrage adapté, notion d'efficacité en puissance

clear;
close all;
clc;

% Les paramètres

Fe = 24000; % Fréquence d'échantillonnage
Rb = 3000; % Débit binaire
Tb = 1/Rb; % Période d'échantillonnage
Te = 1/Fe; % Période d'échantillonnage
N = 1000; % Nombre de bits
Rs = 1/Tb; % Fréquence de symbole
bits = randi([0 1],1,N); % Génération de N bits aléatoires
Ts = 1/Rs; % Période de symbole
Ns = Ts/Te; % Nombre d'échantillons par symbole
M = 4; % Nombre de symboles

%% Modulation

% mapping 4-aires
bits1 = randi([0 1],1,2*N)
% bits = reshape(bits1,2)'
symboles = (2*bit2int(bits1',2) - 3)';
%Sur-échantillonnage
signal_sur_echantillonne = kron(symboles,[1, zeros(1,Ns-1)]);
h = ones(1,Ns);
x = filter(h,1,signal_sur_echantillonne);


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
bits_detecte1 = zeros(1,2*N);
for i = 2:2:2*N+1 
    if signal_echantillonne(i/2) == -24
        bits_detecte1(i-1) = 0;
        bits_detecte1(i) = 0;
    elseif signal_echantillonne(i/2) == -8
        bits_detecte1(i -1) = 0;
        bits_detecte1(i) = 1;
    elseif signal_echantillonne(i/2) == 8
        bits_detecte1(i-1) = 1;
        bits_detecte1(i) = 0;
    else
        bits_detecte1(i-1) = 1;
        bits_detecte1(i) = 1;
    end
end



TEB = sum(bits_detecte1~=bits1)/(2*N);
disp(['TEB = ',num2str(TEB)]);

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
r = x + bruit;

% Le tracé de r
figure;
plot(t,r);
title('Signal bruité');
xlabel('Temps (s)');
ylabel('Amplitude');
axis([0 N*Tb -20 20]);
grid on;

% Réponse impulsionnelle du filtre de réception
hr2 = ones(1,Ns);
z2 = filter(hr2,1,r);

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
bits_detecte2 = zeros(1,2*N);
for i = 2:2:2*N+1 
    if signal_echantillonne2(i/2) <= -16  %decision = -24/Ns = -3
        bits_detecte2(i-1) = 0;          % demapping = 00
        bits_detecte2(i) = 0;
    elseif -16 < signal_echantillonne2(i/2) <= 0   %decision = -8/Ns = -1
        bits_detecte2(i -1) = 0;            % demapping = 01
        bits_detecte2(i) = 1;
    elseif 0 < signal_echantillonne2(i/2) <= 16  %decision = 8/Ns = 1
        bits_detecte2(i-1) = 1;            % demapping = 10
        bits_detecte2(i) = 0;
    else                             %decision = 24/Ns = 3
        bits_detecte2(i-1) = 1;     % demapping = 11
        bits_detecte2(i) = 1;
    end
end
TEB2 = sum(bits_detecte2~=bits1)/N;
disp(['TEB2 = ',num2str(TEB2)]);

% Taux d'erreur binaire pour 0 < TEB < 8
TEB3 = zeros(1,8);
hr3 = ones(1,Ns);
for j = 1:8
    sigma2 = (Ns*Ps)/(4*j);
    bruit = sqrt(sigma2)*randn(1,length(x));
    r = x + bruit;
    z3 = filter(hr3,1,r);
    signal_echantillonne3 = z3(1:Ns:end);
    bits_detecte3 = zeros(1,N);

    for i = 2:2:N+1 
    
        if signal_echantillonne2(i/2) <= -16  %decision = -24/Ns = -3
        
            bits_detecte3(i-1) = 0;          % demapping = 00
        
            bits_detecte3(i) = 0;
    
        elseif -16 < signal_echantillonne2(i/2) <= 0   %decision = -8/Ns = -1
        
            bits_detecte3(i -1) = 0;            % demapping = 01
        
            bits_detecte3(i) = 1;
    
        elseif 0 < signal_echantillonne2(i/2) <=16  %decision = 8/Ns = 1
        
            bits_detecte3(i-1) = 1;            % demapping = 10
        
            bits_detecte3(i) = 0;
    
        else                             %decision = 24/Ns = 3
        
            bits_detecte3(i-1) = 1;     % demapping = 11
        
            bits_detecte3(i) = 1;
    
        end

    end
    error =  bits_detecte3~=bits;
    %TEB3(j) = sum(bits_detecte3~=bits)/);
end
figure;
plot(1:8,TEB3);
title('TEB en fonction de sigma2');
xlabel('sigma2');
ylabel('TEB');
grid on;

