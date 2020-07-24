%%% Linear Optimization using Linprog command. Optimization
%%% problem specified in exercise 1 of SC42055, OPtimization in systems and
%%% controls. 
%%% Niels Uitterdijk, 25-09-2017
clear
close all
clc
%% Student number 4276892
D1 = 8;
D2 = 9;
D3 = 2;
%% Define changing variables
b1 = 1000 + 20*D1;
b2 = 25*(40-D2);
a21 = 3;
a22 = 5;
f1 = 60 - a21*(500+10*D3)/(40-D2);
f2 = 110 - a22*(500+10*D3)/(40-D2);
%% Define matrices
A = [2,3;a21,a22;1,0];
b = [b1,b2,200];
lb = [200, 0];
ub = [1000,1000];
f = [-f1,-f2];
%% Caculating X and the corresponding profit
X = linprog(f,A,b,[0,0],[0],lb,ub);

profit = f1*X(1) + f2*X(2);
%% Outputting results
fprintf('Optimization complete\n\n')
fprintf('Employees: = %.0f\n',25)
fprintf('Profit:    = %.0f\n\n',profit)
fprintf('Falcons    = %.0f\n',X(1))
fprintf('Condors    = %.0f\n\n',X(2))
fprintf('PLC left   = %.0f\n',b1 - 2*X(1) - 3*X(2))
fprintf('Hrs left   = %.0f\n',b2 - a21*X(1) - a22*X(2))
