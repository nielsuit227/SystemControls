%%% Exercise 4
%%% Programme for the Quadratic optimization for SC40055 by Niels
%%% Uitterdijk, 28 Sept 2017. 
%%% Prediction of university students for coming years. X1, X2, X3
%%% represents BSc, MSc, Ph.D. New (k+1) BSc students is in/de-creased by u1(k)

%%% Create an A that minimises the amount of students with minimal X_d =
%%% [2500;600;200]. In order to do so, the equation (X_d-u) - x(n)� = 0
%%% should be minimised. Again a least squares problem. We take Y = X_D,
%%% phi = x(n). Same strategy, so row by row. 
close all
clear
clc
%% Student number
D1 = 8;
D2 = 9;
D3 = 2;
%% Target
X_d = [2500; 600; 200];
load A_&_C_Matrix.mat
%% Dataset
u1(1:9) = [1273 1142 1106 1110 1125 1138 1156 1200 1125];
u2(1:9) = [100 101 102 100 94 91 101 101 100];
u3(1:9) = [42 41 39 38 38 41 41 40 42];
X1(1:10) = [2800 2971 2940 2885 2855 2852 2863 2887 2945 2905];
X2(1:10) = [900 776 729 704 686 668 656 661 665 671];
X3(1:10) = [220 257 275 283 287 289 292 294 294 297];
y1(1:10) = [840 891 882 866 857 856 859 866 884 872];
y2(1:10) = [432 372 350 338 329 321 315 317 319 322];
y3(1:10) = [24 28 30 31 32 32 32 32 32 33];
X(1:10,:) = [X1' X2' X3'];
u(:,1:9) = [u1' u2' u3']';
Y_data(1:10,:) = [y1' y2' y3'];
%% Initials/constraints QP
%%% [X,FVAL,EXITFLAG,OUTPUT,LAMBDA] =quadprog(H,f,A,b,Aeq,beq,LB,UB,X0,OPTIONS
%%% H,f cost function. Ax<b, Aeqx = beq, lb<x<ub,x0 guess.
e = X_d-X(10,:)';
LB = 0;
%% QP problem
%%% We'll do it row by row again, two years in each column. As x(k+1) is
%%% unknown, it's substituded by Ax(k)-Un. As there is already a -Un in the
%%% equation, Phi will be a vector of [1 2]. Row vectors will be used. 
%% Input vectors
Y = [X_d-A*X(10,:)';X_d-A^2*X(10,:)'];
phi = [eye(3);eye(3)+A];
%% Transform
H = 2*phi'*phi;
c = (-2*phi'*Y)';
%% Constraints
Acon = phi;
Bcon = Y;
LB = [0;0];
%% Actual optimization
[u_d,e_d,Flag] = quadprog(H,c,Acon,Bcon,[],[],LB,[],[]);
if Flag ~= 1
    fprintf('Error, optimization did not converge\n')
end
if e_d > 10^-3
    fprintf('Cost function error too large\n')
end
%% Modelling with new U_D
for n=1:2
    X(n+10,:) = (A*X(n+9,:)' + u_d)';   %Calculating X for 2019, 2020
    Y_data(n+10,:) = (C*X(n+10,:)')';        %Calculating Y for 2019, 2020
end
%% Plot data X1
t = linspace(2018,2020,3);
Xd = [X_d';X_d';X_d'];
figure('units','normalized','outerposition',[0 0 1 1],'name','Predictive model and the original data of the amount of students')
subplot1 = subplot(1,3,1);
plot(t,X(10:12,1),'linewidth',2)
set(subplot1,'FontSize',14);
title('BSc Students')
hold on
plot(t,Xd(:,1),'linewidth',2)
legend('Model','Target')
%% plot data X2
subplot2 = subplot(1,3,2);
set(subplot2,'FontSize',14);
plot(t,X(10:12,2),'linewidth',2)
title('MSc Students')
hold on
plot(t,Xd(:,2),'linewidth',2)
legend('Model','Target')
%% plot data X3
subplot3 = subplot(1,3,3);
set(subplot3,'FontSize',14);
plot(t,X(10:12,3),'linewidth',2)
title('Ph.D. Students')
hold on
plot(t,Xd(:,3),'linewidth',2)
legend('Model','Target')
