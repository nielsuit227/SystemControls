clear
close all
clc
%% Initials
J1 = 10/9;
J2 = 10;
c = 0.1;
k = 1;
ki = 1;
t = linspace(0,10,1000);
Td = sin(t);
phi2(1:length(t)) = 0;
phi1(1) = 0;
x = zeros(4,length(t));
x(:,1) = 0;
u(2,:) = Td;
%% State space
A = [0 0 1 0; 0 0 0 1; -k/J1 k/J1 -c/J1 c/J1;k/J2 -k/J2 c/J2 -c/J2];
B = [0 0 ; 0 0; ki/J1 0 ; 0 1/J2];
C = [1 0 0 0; 0 1 0 0];
D = [0 0; 0 0];
%% Determine Jordan form A
[S,J] = jordan(A);
%% Determine result with I = 0
sys1 = ss(A,B,C,D);
[y,t,x] = lsim(sys1,u,t);
%% Calculating I and simulating the system
u(1,:) = 91/909*sin(t) - 10000/909*exp(-10*t) - 100/909*cos(t);
[y,t,x] = lsim(sys1,u,t);
%% Plotting
figure
plot(t,y(:,1),t,y(:,2),t,Td,t,u(1,:))
title('Td = sin(t)')
legend('Phi 1','Phi 2','Td','I')
%% Setting new Td, I and simulating the new system
u(2,:) = 20*Td;
u(1,:) = u(1,:)*20; 
[y2,t,x2] = lsim(sys1,u,t);
%% Plotting 2
figure
plot(t,y2(:,1),t,y2(:,2),t,Td,t,u(1,:))
title('Td = 20 sin(t)')
legend('Phi 1','Phi 2','Td','I')





    