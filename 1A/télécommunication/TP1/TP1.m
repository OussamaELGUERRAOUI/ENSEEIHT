!clear all;
close all;
clc;

% Les paramètres

Fe = 24000; % Fréquence d'échantillonnage
Rb = 3000; % Débit binaire
Tb = 1/Rb; % Période d'échantillonnage
Te = 1/Fe; % Période d'échantillonnage

%% Modulateur 1 :

% Le signal binaire
N = 100; % Nombre de bits
Rs = 1/Tb; % Fréquence de symbole
bits = randi([0 1],1,N); % Génération de N bits aléatoires
Ts = 1/Rs; % Période de symbole
Ns = Ts/Te; % Nombre d'échantillons par symbole


%Mapping
symboles = 2*bits-1;

%Sur-échantillonnage
signal_sur_echantillonne = kron(symboles,[1, zeros(1,Ns-1)]);

temps = 0:Te:(length(signal_sur_echantillonne)-1)*Te; % Vecteur temps

%Filtrage
h1 = ones(1,Ns);
x = filter(h1,1,signal_sur_echantillonne);

figure(1)
plot(temps,x);
title('Signal modulé');
xlabel('Temps (s)');
ylabel('Amplitude');
axis([0 N*Tb -1.5 1.5]);
grid on;

%Densité spectrale de puissance
figure;
% DSP = pwelch(x,[],[],[],Fe); (Marche mal)
NFFT = 2^nextpow2(length(x));
DSP = abs(fft(x,NFFT)).^2;
f = linspace(-Fe/2,Fe/2,length(DSP));
semilogy(f,fftshift(DSP));
title('DSP du signal modulé');
xlabel('Fréquence (Hz)');
ylabel('DSP');
grid on;

%Trac ́es superpos ́es sur une mˆeme figure de la DSP estim ́ee du signal g ́en ́er ́e et de sa DSP th ́eorique.
figure;
% DSP_th = (1/Tb)*rectpuls(f,Tb);
DSP_th1 = (Ts*(sin(pi*f*Ts/2)).^4)./((pi*f*Ts/2).^2);
semilogy(f,fftshift(DSP_th1));
% hold on;
% plot(f,fftshift(DSP));
% title('DSP du signal modulé');
% xlabel('Fréquence (Hz)');
% ylabel('DSP');
% legend('DSP théorique','DSP estimée');
grid on;

%% modulateur 2 
% mapping 4-aires
bits1 = randi([0 1],1,2*N)
symboles2 = (2*bit2int(bits1',2) - 3)';
%Sur-échantillonnage
signal_sur_echantillonne2 = kron(symboles2,[1, zeros(1,Ns-1)]);
temps2 = 0:Te:(length(signal_sur_echantillonne2)-1)*Te; % Vecteur temps

%Filtrage
h2 = ones(1,Ns);
x2 = filter(h2,1,signal_sur_echantillonne2);

figure;
plot(temps2,x2);
title('Signal modulé');
xlabel('Temps (s)');
ylabel('Amplitude');
axis([0 N*Tb -1.5 1.5]);
grid on;

%Densité spectrale de puissance
figure;
% DSP2 = pwelch(x2,[],[],[],Fe); (Marche mal)
%NFFT2 = 2^nextpow2(length(x2));
DSP2 = abs(fft(x2,2^nextpow2(length(x2)))).^2;
f = linspace(-Fe/2,Fe/2,length(DSP2));
plot(f,fftshift(DSP2));
title('DSP du signal modulé');
xlabel('Fréquence (Hz)');
ylabel('DSP');
grid on;

%Traces superposes sur une mˆeme figure de la DSP estim ́ee du signal g ́en ́er ́e et de sa DSP th ́eorique.
figure;
% DSP_th2 = (1/Tb)*rectpuls(f,Tb);
DSP_th2 = (Ts*(sin(pi*f*Ts/2)).^4)./((pi*f*Ts/2).^2);
semilogy(f,fftshift(DSP_th2));
% hold on;
% plot(f,fftshift(DSP2));
% title('DSP du signal modulé');
% xlabel('Fréquence (Hz)');
% ylabel('DSP');
% legend('DSP théorique','DSP estimée');
grid on;




%% Modulateur 3 :
bits = randi([0 1],1,N); % Génération de N bits aléatoires
alpha = 0.5; % Facteur de suréchantillonnage


%Mapping
symboles3 = 2*bits - 1;

%Sur-échantillonnage
signal_sur_echantillonne3 = kron(symboles3,[1, zeros(1,Ns-1)]);
temps3 = 0:Te:(length(signal_sur_echantillonne3)-1)*Te; % Vecteur temps

% Filtrage
h3 = rcosdesign(alpha,8,Ns,'sqrt');
x3 = filter(h3,1,signal_sur_echantillonne3);

figure;
plot(temps3,x3);
title('Signal modulé');
xlabel('Temps (s)');
ylabel('Amplitude');
axis([0 N*Tb -1.5 1.5]);
grid on;

%Densité spectrale de puissance
figure;
% DSP3 = pwelch(x3,[],[],[],Fe); (Marche mal)
NFFT3 = 2^nextpow2(length(x3));
DSP3 = abs(fft(x3,NFFT3)).^2;
f = linspace(-Fe/2,Fe/2,length(DSP3));
semilogy(f,fftshift(DSP3));
title('DSP du signal modulé');
xlabel('Fréquence (Hz)');
ylabel('DSP');
grid on;

%Traces superposes sur une meme figure de la DSP estim ́ee du signal g ́en ́er ́e et de sa DSP th ́eorique.
F_limite_1 = (1-alpha)/2*Ts;
F_limite_2 = (1+alpha)/2*Ts;
DSP_th3 = zeros(1,length(f));
variance_symbole_emis = 1;
DSP_th3(abs(f) <= F_limite_1) = variance_symbole_emis;
DSP_th3((F_limite_1 <= abs(f)) & (abs(f) <= F_limite_2)) = variance_symbole_emis/2 * (1 + cos(pi*Ts/alpha*abs(f(F_limite_1 <= abs(f) & abs(f) <= F_limite_2))) - F_limite_1);
figure;
semilogy(f,fftshift(DSP_th3));
hold on;
semilogy(f,fftshift(DSP3));
title('DSP du signal modulé');
xlabel('Fréquence (Hz)');
ylabel('DSP');
legend('DSP théorique','DSP estimée');
grid on;

%trac´e superpos´e des DSP des diff´erents signaux g´en´er´es pour un mˆeme d´ebit binaire
figure;
semilogy(f,fftshift(DSP_th1));
hold on;
semilogy(f,fftshift(DSP_th2));
semilogy(f,fftshift(DSP_th3));
title('DSP du signal modulé');
xlabel('Fréquence (Hz)');
ylabel('DSP');
legend('DSP théorique 1','DSP théorique 2','DSP théorique 3');
grid on;

%% Etude des interférences entre symbole et du critère de Nyquist

%chaine de transmission en bande de base sans bruit
% modulation
% Le signal binaire
N = 100; % Nombre de bits
Rs = 1/Tb; % Fréquence de symbole
bits = randi([0 1],1,N); % Génération de N bits aléatoires
Ts = 1/Rs; % Période de symbole
Ns = Ts/Te; % Nombre d'échantillons par symbole


%Mapping
symboles = 2*bits-1;

%Sur-échantillonnage
signal_sur_echantillonne = kron(symboles,[1, zeros(1,Ns-1)]);

temps = 0:Te:(length(signal_sur_echantillonne)-1)*Te; % Vecteur temps

%Filtrage
h1 = ones(1,Ns);
x = filter(h1,1,signal_sur_echantillonne);

%démodulation

hr = h1; %filtre de réception
z = filter(hr,1,x);
t = 0:Te:(length(z) - 1)*Te
figure;
plot(t,z);
title('Signal en sortie du filtre de r´eception');
xlabel('Temps (s)');
ylabel('Amplitude');
axis([0 N*Tb -10 10]);
grid on;

% Le tracé de la réponse impulsionnelle globale de la chaine de transmission g
g= conv(h1,hr);
tg = 0:Te:(length(g) - 1)*Te
figure;
plot(tg,g);
title('Le tracé de la réponse impulsionnelle globale de la chaine de transmission');
xlabel('Temps (s)');
ylabel('Amplitude');
grid on;


%diagramme d'oeil
figure;
plot(reshape(z,Ns,length(z)/Ns));
title("diagramme de l'oeil");
xlabel('Temps(s)');
ylabel("Amplitude de l'œil");
axis([0 Ns+1 -10 10]);

z_t0plusmTs = z(Ns:Ns:length(z));
decision = sign(z_t0plusmTs);

for i =1:N
    if decision(i) < 0 
        Taux_error(i) = 0;
    else
        Taux_error(i) = 1;
    end
end

TE = Taux_error ~= bits;
TEB = sum(TE)/N ;

%2 on modifie  les instants dé´echantillonnage dans votre implantation pr´ec´edente pour échantillonner
% à n0 + mNs, avec n0 = 3

z_t0plusmTs1 = z(3:Ns:length(z));
decision1 = sign(z_t0plusmTs1);

for i =1:N
    if decision1(i) < 0 
        Taux_error1(i) = 0;
    else
        Taux_error1(i) = 1;
    end
end

TE1 = Taux_error1 ~= bits;
TEB1 = sum(TE1)/N ;


%% Etude avec canal de propagation sans bruit
BW1 = 8000; % largeur de bande du signal 1 en Hz
BW2 = 1000; % largeur de bande du signal 2 en Hz
%  filtre passe-bas représentant le canal de propagation
h_bas_1 = fir1(100,2*BW1/Fe);
h_bas_2 = fir1(100,2*BW2/Fe);

%  Le tracé de la réponse impulsionnelle du filtre passe-bas
figure;
plot(h_bas_1);
title('Le tracé de la réponse impulsionnelle du filtre passe-bas');
xlabel('Temps (s)');
ylabel('Amplitude');
grid on;
hold on;
plot(h_bas_2);
legend('Signal 1','Signal 2');


% Les réponses impulsionnelles globales de la chaine de transmission
g_globale1 = conv(g,h_bas_1);
g_globale2 = conv(g,h_bas_2);

% Le tracé de la réponse impulsionnelle globale de la chaine de transmission
figure;
plot(g_globale1);
title('Le tracé de la réponse impulsionnelle globale de la chaine de transmission');
xlabel('Temps (s)');
ylabel('Amplitude');
grid on;
hold on;
plot(g_globale2);
legend('Signal 1','Signal 2');

% Le diagramme de l'oeil
figure;
plot(reshape(z,Ns,length(z)/Ns));
title("diagramme de l'oeil");
xlabel('Temps(s)');
ylabel("Amplitude de l'œil");
axis([0 Ns+1 -10 10]);

% Tracé, sur une meme figure, de |H(f)Hr(f)| et de |Hc(f)|

% La réponse en fr´equence du filtre de mise en forme
H = fft(h1,Fe);
H = fftshift(H);
f = -Fe/2:Fe/2-1;


% La réponse en fréquence du filtre de réception
Hr = fft(hr,Fe);
Hr = fftshift(Hr);

% La réponse en fr´equence du filtre canal
Hc = fft(h_bas_1,Fe);
Hc = fftshift(Hc);

% Tracé sur une meme figure, de |H(f)Hr(f)| et de |Hc(f)|

figure;
plot(f,abs(H.*Hr));
title('Tracé sur une meme figure, de |H(f)Hr(f)| et de |Hc(f)|');
xlabel('Fréquence (Hz)');
ylabel('Amplitude');
axis ([-Fe/2 Fe/2 -5 70]);
grid on;
hold on;
plot(f,abs(Hc));
legend('|H(f)Hr(f)|','|Hc(f)|');







