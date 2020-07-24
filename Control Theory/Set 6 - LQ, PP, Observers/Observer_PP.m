%%% Exercise 5 of set 5. Compare LQ optimal control to pole placement
%%% control of Exercise 3 of set 4. The original assignment S4E3 stays here
%%% and below the LQ optimal control is assessed. 
%%% 16/10/17 Niels Uitterdijk
%% Init
close all
clc
clear
%% Constants
J1 = 10/9;
J2 = 10;
c = 0.1;
k = 1;
ki = 1;
%% State space
A = [0 0 1 0; 0 0 0 1; -k/J1 k/J1 -c/J1 c/J1;k/J2 -k/J2 c/J2 -c/J2];
B = [0 0 ; 0 0; ki/J1 0 ; 0 1/J2];
C = [1 0 0 0; 0 1 0 0];
D = [0 0; 0 0];
Bci = B(:,1);       % Control Input
Bd = B(:,2);        % Disturbances
%% Observer
L = place(A',C',[-4 -2 -3 -2])';
%% Feedback to place eigenvalues
F = place(A,Bci,[-2;-1;-4;-5]);
%% Boundary
t = linspace(0,50,10000)';
u = [square(3*t(1:length(t)/2));zeros(length(t)/2,1)];
X0 = [.1 -.1 .1 -.1 zeros(1,4)]';
%% System Definition
% ss(A,B,C,D) [y,t,x]=lsim(sys,u,t,x0)
Aobfb = [A Bci*-F;L*C A-L*C-Bci*F];
Bobfb = [Bd;zeros(4,1)];
Cobfb = [C zeros(2,4);zeros(4,4) eye(4)];
ObFb = ss(Aobfb,Bobfb,Cobfb,0);

%% Simulate system
[y,t,x] = lsim(ObFb,u,t,X0);

%% Plot everything
figure
subplot(2,2,1)
plot(t,y(:,1),t,y(:,3))
legend('Disk 1','Adaptive Disk 1')
title('Output')

subplot(2,2,2)
plot(t,x(:,3),t,x(:,7),t,x(:,4),t,x(:,8))
legend('Velocity Disk 1','Observed Velocity Disk 1','Velocity Disk 2','Observed Velocity Disk 2')
title('Control')

subplot(2,2,3)
plot(t,u)
title('Disturbance')

subplot(2,2,4)
plot(t,y(:,2),t,y(:,4))
legend('Disk 2','Observed Disk 2')


