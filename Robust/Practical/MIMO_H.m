clear
close all
clc
load('FLoatingWindTurbine.mat');
G = ss(A,B,C,D);
Gd = G(:,3);
G = G(:,1:2);
Gdtf = tf(Gd);
Gtf = tf(G);
%% Gsim
warning off
systemnames ='FWT';                     % Entire Model of Folating Wind Turbine
inputvar ='[V; Beta; Tau]';             % Input of the generalized plant
input_to_FWT= '[Beta; Tau; V]';
outputvar= '[FWT; Beta; Tau; FWT]';     % Output of the generalized plant
sysoutname='Gsim';
sysic;
%% RGA
% Both RGA's are below zero initially, meaning that the input/output is
% wrongly written. The RGA's found when switching the inputs are 1.6654 and
% 1.0378. The RGA gets smaller towards the bandwidth.
Gtf2(1,:) = Gtf(2,:);
Gtf2(2,:) = Gtf(1,:);
RGA = Gtf2.*inv(Gtf2)';
L0 = bode(RGA(1,1),0);
L03Hz = bode(RGA(1,1),0.3*2*pi);
%% MIMO poles
% We only have LHP poles and zeros. Therefore we conclude that the plant is 
% nominal stable. Furthermore we have 2 complex polepairs plus one 
% real pole. We have one complex zero pair.
p = eig(G.A);
z = tzero(G);
%% Generalized Plant
Wp = tf([1/1.5 0.6*pi],[1 pi*0.6e-4]); Wp(2,2) = 0.08;
Wu(2,2) = tf([1/130 1.5e-4],[1 1.5e-6]); Wu(1,1) = 0.01; 
w = Gd.B;
u = G.B;
systemnames = 'G Wp Wu';
inputvar = '[w(2);u(2)]';
input_to_G = '[u]';
input_to_Wp = '[w+G]';
input_to_Wu = '[u]';
outputvar = '[Wp;Wu;G+w]';
sysoutname = 'P';
sysic;
[K,CL,GAM,INFO] = hinfsyn(P,2,2);
%% Step Response Controller
CL=lft(Gsim,K); % Closed Loop Response with H-inf Cont.
step(CL);
%% Generalized Nyquist 
L = G*K;
w1 = 10e-5;
w2 = 10;
W = linspace(w1,w2,w2/w1);
for n=1:size(W)
    gen_nyq(n) = det( eye(2) + evalfr(L,W(n)));
end
figure
plot(real(gen_nyq),imag(gen_nyq))



