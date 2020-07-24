clear
close all
clc
load('FLoatingWindTurbine.mat');
G = ss(A,B,C,D);
s = tf('s');
%% Bode OPTS
opts = bodeoptions('cstprefs');
opts.PhaseWrapping = 'on';
%% Gsim
warning off
systemnames ='FWT';                     
inputvar ='[V; Beta; Tau]';             
input_to_FWT= '[Beta; Tau; V]';
outputvar= '[FWT; Beta; Tau; FWT]';     
sysoutname='Gsim';
sysic;
%% Checking Bode plot from beta to omega
G11 = tf(-G(1,1));
%% Controller
% Parameters
Kp = 1; Ti = 1; Td = 0;             % PID
b1 = 0.2; b2 = 0.7; w = 0.25;       % Notch
% Controller
PID = Kp*(1 + Ti*(1/s) + Td*s);                     % PID filter
notch = tf([1 2*w*b1 w^2],[1 2*w*b2 w^2]);          % Notch filter
K = PID*notch;                                      % Controller                                 
%% Implementing time domain
CL_siso=minreal(lft(Gsim(1:end-1,1:end-1),K));
[xsiso,ts] = step(CL_siso);
%% Splitting to G & Gd
G = minreal(ss(A,B,C,D));
Gd = minreal(G(:,3));
G = minreal(G(:,1:2));
Gtf = tf(G);
%% 4. RGA
Gtf_0 = evalfr(Gtf,0);
Gtf_03Hz = evalfr(Gtf,0.6*pi);
RGA_0 = inv(Gtf_0)'.*Gtf_0;
RGA_03Hz = inv(Gtf_03Hz)'.*Gtf_03Hz;
%% 5. MIMO poles
p = eig(G.A);
z = tzero(G);
%% 8. Generalized Plant
Wp = tf([1/4 0.6*pi],[1 pi*0.6e-3]); Wp(2,2) = 0.08;
Wu(2,2) = tf([1/130 1.5e-4],[1 1.5e-6]); Wu(1,1) = 0.01; 
w = Gd.B;
u = G.B;
systemnames = 'G Wp Wu';
inputvar = '[w(2);u(2)]';
input_to_G = '[u]';
input_to_Wp = '[w+G]';
input_to_Wu = '[u]';
outputvar = '[Wp;Wu;-G-w]';
sysoutname = 'P';
sysic;
[K_h,~,Ninf,~] = hinfsyn(P,2,2);
CL_mimo=minreal(lft(Gsim,-K_h)); % Closed Loop Response with H-inf Cont.
[xmimo,tm] = step(CL_mimo);
%% 11. Generalized Nyquist 
L = G*-K_h;
W = linspace(10e-4,3,3/10e-4);
Wn = linspace(-10e-4,-3,3/10e-4);
for n=1:size(W,2)
    frmL = evalfr(L,j*W(n));
    frmLn = evalfr(L,j*Wn(n));
    gen_nyq(n) = det(eye(2)+frmL);
    gen_nyqn(n) = det(eye(2)+frmLn);
end
%% 16. Sensitivity plot
L = minreal(G*K_h);
S_hinf = minreal(inv(eye(2) + L));
KS = minreal(K_h*S_hinf);
T = minreal(L*S_hinf);
%% 17. Time Domain Specification
P_siso = 1e4.*(180+xsiso(:,1));
P_mimo = (1e4 + xmimo(:,4)).*(180+xmimo(:,1));
%% 18. Uncertainty definitions
Wo1 = tf([1/100 0.2],[1/100 1]);
Wi1 = tf([1/18/pi 0.3],[1/64/pi 3]);
Wo = [Wo1 0;0 Wo1];
Wi = [Wi1 0;0 Wi1];
Do=minreal([ultidyn('Do1',[1,1]) 0; 0 ultidyn('Do2',[1,1])]);
Di=minreal([ultidyn('Di1',[1,1]) 0; 0 ultidyn('Di2',[1,1])]);
D = minreal([Do zeros(2,2);zeros(2,2) Di]);
Gp = (eye(2)+Wi*Di)*G*(eye(2)+Wo*Do);
%% 19. Condition number of SV
gammay = sigma(G);
conditionnumber = 10.^(gammay(1,:)./20)./(10.^(gammay(2,:)./20));
%% 24. Uncertain Generalized Plant
systemnames = 'G Wp Wu Wo Wi';
inputvar = '[Do(2); Di(2); w(2);u(2)]';
input_to_G = '[u+Di]';
input_to_Wp = '[w+G+Do]';
input_to_Wu = '[u]';
input_to_Wo = '[G]';
input_to_Wi = '[u]';
outputvar = '[Wo;Wi;Wp;Wu;-G-w-Do]';
sysoutname = 'P_h';
cleanupsysic = 'yes';
sysic;
N = minreal(lft(P_h,K_h));      %% Define N with gen_plant and old controller
F = minreal(lft(N,D));
% Nominal Stability
pole(N)
% Nominal Performance
muNP = mussv(N(5:8,5:6),[2 4]);
muNP_SSV = norm(muNP(:,1),inf)
% Robust Stability
muRS = mussv(N(1:4,1:4),ones(4,2));
muRS_max = norm(muRS(:,1),inf)
% Robust Performance
block = ones(5,2);
block(5,1) = 2; block(5,2) = 4;
muRP = mussv(N,block);                      %% Calculating SSV for full N
muRP_max = norm(muRP(:,1),inf)
%% 28. DK-iterations
omega=logspace(-3,3,61);
opt=dkitopt('FrequencyVector', omega);
Punc = lft(D,P_h);
[K_dk,clp,bnd,dkinfo]=dksyn(Punc,2,2,opt);
N = minreal(lft(P_h,K_dk));      %% Define N with gen_plant and old controller
% Nominal Stability
pole(N)
% Nominal Performance
muNP_SV = norm(N(5:8,5:6),inf);
muNP = mussv(N(5:8,5:6),[2 4]);
muNP_SSV = norm(muNP(:,1),inf)
% Robust Stability
muRS = mussv(N(1:4,1:4),ones(4,2));
muRS_max = norm(muRS(:,1),inf)
% Robust Performance
block = ones(5,2);
block(5,1) = 2; block(5,2) = 4;
muRP = mussv(N,block);                      %% Calculating SSV for full N
muRP_max = norm(muRP(:,1),inf)
%% 29. Time domain
clp = minreal(lft(Gsim,-K_dk));
[dkmimo,tdk] = step(clp);
P_dk_mimo = (1e4 + dkmimo(:,4)).*(180+dkmimo(:,1));
%% 30. Frequency Domain
S_dk = minreal(inv(eye(2) + G*K_dk));


%% Plots
% Bode Analysis Plant (Beta to Omega)
figure
bode(G11)                                           % Plant
hold on
bode(K*G11,opts)                                    % Loop gain
S_siso = inv(1+K*G11);                              % Sensitivity for Bandwidth
bode(S_siso,opts)
bode(tf([1]),'k',opts)
legend('Plant','Loop gain','Sensitivity')
% Step SISO controller
figure
step(CL_siso)
% Generalized Nyquist
figure
plot(real(gen_nyq),imag(gen_nyq),'b',real(gen_nyqn),imag(gen_nyqn),'b')
% Step H-inf controller
figure
step(CL_mimo)
% Weights for H-inf controller
figure
bodemag(S_hinf(1,1))
hold on
bodemag(1/Wp(1,1))
bodemag(Wp(1,1)*S_hinf(1,1))
legend('S','1/W_p','W_p S')
Ninf_Wp = norm(Wp(1,1)*S_hinf(1,1),inf);
figure
bodemag(KS(2,1))
hold on
bodemag(1/Wu(2,2))
bodemag(Wu(2,2)*KS(2,1))
legend('KS','1/W_u','W_u K S')
Ninf_Wu = norm(KS(2,1)*Wu(2,2),inf);
% Singular Value plots
figure
sigma(G,'r')
hold on
sigma(Gp,'b');
figure
sigma(G,'k',G(1,1),'b',G(2,2),'r',G(2,1), 'y',G(1,2), 'g')
legend('|G(j\omega)|','|G_{11}(j\omega)|','|G_{22}(j\omega)|','|G_{21}(j\omega)|','|G_{12}(j\omega)|')
% Time domain analysis DK controller
figure
step(clp)
% Power comparison three controllers 
figure
plot(ts,P_siso*1e-6)
hold on
plot(tm,P_mimo*1e-6)
plot(tdk,P_dk_mimo*1e-6)
legend('SISO','H_\infty MIMO','DK-iterations MIMO')
title('Power comparison')
xlabel('Time [s]')
ylabel('Output Power [MW]')
% Sensitivity comparison three controllers
figure
bodemag(S_dk(1,1))
hold on
bodemag(S_hinf(1,1))
bodemag(S_siso(1,1))
bodemag(tf([10^(-3/20)]))
legend('DK','H_\infty','SISO','-3dB')
% Open loop comparison three controllers
figure
bodemag(G*K_dk)
hold on
bodemag(G*K_h)
bodemag(G11*K)
legend('DK','H_\infty','SISO')

