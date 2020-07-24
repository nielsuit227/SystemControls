%%% Programme for the Quadratic optimization for SC40055 by Niels
%%% Uitterdijk, 28 Sept 2017. 
%%% Prediction of university students for coming years. X1, X2, X3
%%% represents BSc, MSc, Ph.D. New (k+1) BSc students is in/de-creased by u1(k)
close all
clear
clc
%% Student number
D1 = 8;
D2 = 9;
D3 = 2;
%% Known parameters
a3 = 0.05 + D1/200;
b3 = 0.05 - D2/200;
c3 = 0.1 + D3/200;
%% Dataset
u1(1:9) = [1273 1142 1106 1110 1125 1138 1156 1200 1125];
u2(1:9) = [100 101 102 100 94 91 101 101 100];
u3(1:9) = [42 41 39 38 38 41 41 40 42];
X1(1:10) = [2800 2971 2940 2885 2855 2852 2863 2887 2945 2905];
X2(1:10) = [900 776 729 704 686 668 656 661 665 671];
X3(1:10) = [220 257 275 283 287 289 292 294 294 297];
X(1:10,:) = [X1' X2' X3'];
u(:,1:9) = [u1; u2; u3];
%% QP
Y1 = X1(2:10)';
phi = [-X1(1:9)' -X2(1:9)' -X3(1:9)' u(1,1:9)'];
%% Solving for X
% [X, FVAL, Exitflag, output, lambda] = quadprog(H,f,A,b,Aeq,beq,LB,UB,X0,Options,
H = 2*phi'*phi;
c = (-2*phi'*Y1)';
x = quadprog(H,c,[],[],[],[]);