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
%% Kalmann matrix
K = [B A*B A^2*B A^3*B];
[L,U] = lu(K);
%% Eigenvalue A
Eigenvalues_A = eig(A);
%% Desired eigenvalues
Eigen_d = [-2;-1;-1+i;-1-i];
F = place(A,B,Eigen_d)
%% Check response
tmax = 50;
samplefreq = 1000;
t = linspace(0,tmax,tmax*samplefreq);
X0 = [1;1;1;1];
%% lsim
T_d = zeros(tmax*samplefreq,1);
T_d(floor(tmax/2*samplefreq):floor(tmax*samplefreq-15*samplefreq)) = 5;
T_d(floor(tmax/4*samplefreq):floor(tmax/3*samplefreq)) = -15;
U = [zeros(1,tmax*samplefreq);T_d'];
sys1 = ss(A-B*F,B,zeros(size(A)),0);
[Y, T, X] = lsim(sys1,U,t,X0);

figure
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

subplot2 = subplot(1,2,2);
plot(t,T_d,'linewidth',2)

set(subplot2,'FontSize',14);
axis([0,tmax,-25,25])
grid on
legend('Disturbance torque')

%% Checking the DC Gain
DC_Gain = dcgain(sys1);

    
