%%% Exercise 5 of set 5. Compare LQ optimal control to pole placement
%%% control of Exercise 3 of set 4. The original assignment S4E3 stays here
%%% and below the LQ optimal control is assessed. 
%%% 16/10/17 Niels Uitterdijk
%% Init
clf('reset')
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
%% Feedback to place eigenvalues
Eigen_d = [-5;-1;-1+i;-1-i];
F_pp = place(A,B,Eigen_d);
%% Optimal LQ feedback
Q1 = 1; Q2 = 50; Q3 = 1; Q4 = .11; R = .1;
Q = [Q1 0 0 0; 0 Q2 0 0; 0 0 Q3 0; 0 0 0 Q4];
H = [A -B*R^-1*B'; -Q -A'];
[Ev, Dv] = eig(H);
[n,n] = size(A);
Z = [];
for j=1:2*n;
if real(Dv(j,j))<0;Z=[Z Ev(:,j)];end;
end;
T11=Z(1:n,:);T21=Z(n+1:2*n,:);
P=T21*T11^(-1);
F_lq = R^-1*B'*P;
%% Check response
tmax = 50;
samplefreq = 1000;
t = linspace(0,tmax,tmax*samplefreq);
X0 = [1;1;1;1];
%% Disturbances
T_d = zeros(tmax*samplefreq,1);
T_d(floor(tmax/2*samplefreq):floor(tmax*samplefreq-15*samplefreq)) = 5;
T_d(floor(tmax/4*samplefreq):floor(tmax/3*samplefreq)) = -15;
U = [zeros(1,tmax*samplefreq);T_d'];
%% Linear simulation Pole Placement
syspp = ss(A-B*F_pp,B,zeros(size(A)),0);
[Y, T, X] = lsim(syspp,U,t,X0);
%% Linear simulation LQ optimal
syslq = ss(A-B*F_lq,B,zeros(size(A)),0);
[Y2, T2, X2] = lsim(syslq,U,t,X0);
%% Plot Pole Placement
subplot1 = subplot(1,2,1);
plot(t,X(:,1),'linewidth',2)
hold on
plot(t,X(:,2),'linewidth',2)
plot(t,X(:,3),'linewidth',2)
plot(t,X(:,4),'linewidth',2)
plot(t,T_d/10,'linewidth',2)
set(subplot1,'FontSize',14);
axis([0,tmax,-5,5])
legend('Angle disk 1','Angle disk 2','Velocity disk 1','Velocity disk 2','Disturbance torque / 10')
grid on
% subplot2 = subplot(1,2,2);
% plot(t,T_d,'linewidth',2)
% set(subplot2,'FontSize',14);
% axis([0,tmax,-25,25])
% grid on
% legend('Disturbance torque')
%% Plot LQ optimal
subplot2 = subplot(1,2,2);
plot(t,X2(:,1),'linewidth',2)
hold on
plot(t,X2(:,2),'linewidth',2)
plot(t,X2(:,3),'linewidth',2)
plot(t,X2(:,4),'linewidth',2)
plot(t,T_d/10,'linewidth',2)
set(subplot2,'FontSize',14);
axis([0,tmax,-5,5])
legend('Angle disk 1','Angle disk 2','Velocity disk 1','Velocity disk 2','Disturbance torque / 10')
grid on
% subplot2 = subplot(1,2,2);
% plot(t,T_d,'linewidth',2)
% set(subplot2,'FontSize',14);
% axis([0,tmax,-25,25])
% grid on
% legend('Disturbance torque')

    
