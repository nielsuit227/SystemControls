%%% This script calculates the optimal gain parameters k and l for a model
%%% reference controller. The aim of the controller is to make the output
%%% of the plant follow a reference model. 
close all
clear
clc
%% System description
Yp = tf([1 1.5],[1 0.75 2.5]);
Ym = tf([1 50],[1 15 50]);
%% Rewrite to State Space
Ap = [-0.75 -2.5;1 0]; Bp = [1;0]; Cp = [1 1.5]; Dp = 0;
yp = ss(Ap,Bp,Cp,Dp);
Am = [-15 -50;1 0]; Bm = [1;0]; Cm = [1 50]; Dm = 0;
ym = ss(Am,Bm,Cm,Dm);
%% Determine full state MRC
K = Bp\(Ap-Am);
L = Bp\Bm;
%% Simulate the full state MRC
r = zeros(1,10000); r(100:10000) = 10;
t = linspace(0,10,10000);
[yms,t,xms] = lsim(ym,r,t);
MRC_FS = ss(Ap-Bp*K,Bp*L,Cp,Dp); yp0 = [1;1];
[Yps,t,xps] = lsim(MRC_FS,r,t,yp0);
% Plot results
figure
plot(t,xms(:,1),'b',t,xms(:,2),'b',t,xps(:,1),'r',t,xps(:,2),'r')
legend('Reference Model state 1','Reference Model state 1','Controlled Plant state 1','Controlled Plant state 2')
%% MRC output measurement controller design (Calculating theta)
% Plant/ref mod parameters
Mp  =2; Np = 3;n_star = 1; Kp = 1;
Km = 1; b1 = 1; b0 = 1.5; a1 = 0.75; a0 = 2.5;
% Controller parameters
c0 = Km/Kp;
A = [1 0 1;0.75 1 51.5;2.5 1.5 75];
b = [34.25;-32.5;50];
theta = A\b;
%% MRC output measurement controller design (Rp = Hurwitz)
% As Rp is Hurwitz (Complex eigenvalues with real -0.375), we can take a
% simplified controller as given in equation 6.3.7 from the book. 
Zp = tf([1 1.5],[1]); Rp = tf([1 0.75 2.5],[1]);
Zm = tf([1 50],[1]); Rm = tf([1 15 50],[1]);
MRC_OM1 = Km/Kp*Zm/Rm*Rp/Zp; Yh = MRC_OM1*Yp;
figure
step(Yh)
hold on
step(Ym)
