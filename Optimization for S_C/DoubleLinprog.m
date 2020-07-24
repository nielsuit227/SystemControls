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
%% Optimizations loop
for z = 1:100
    %% Define changing variables
    b1 = 1000 + 20*D1;
    b2(z) = (25+z)*(40-D2);
    a21(z) = 3 - z/20;
    a22(z) = 5 - z/20;
    f1(z) = 60 - a21(z)*(500+10*D3)/(40-D2);
    f2(z) = 110 - a22(z)*(500+10*D3)/(40-D2);
    %% Define matrices
    A = [2,3;a21(z),a22(z);1,0];
    b = [b1,b2(z),200];
    lb = [200, 0];
    ub = [1000,1000];
    f = [-f1(z),-f2(z)];
    %% Caculating X and the corresponding profit
    X(:,z) = linprog(f,A,b,[0,0],[0],lb,ub);
    
    profit(z) = 60*X(1,z) + 110*X(2,z) - (25+z)*(500+10*D3);
    hrsleft(z) = b2(z) - a21(z)*X(1,z) - a22(z)*X(2,z);
    if hrsleft(z) < -10^3
        profit(z) = 0;
    end
end
[Profit,Z] = max(profit);
fprintf('Optimization complete\n\n')
fprintf('Employees: = %.0f\n',25+Z)
fprintf('Profit:    = %.0f\n\n',Profit)
fprintf('Falcons    = %.0f\n',X(1,Z))
fprintf('Condors    = %.0f\n\n',X(2,Z))
fprintf('PLC left   = %.0f\n',b1 - 2*X(1,Z) - 3*X(2,Z))
fprintf('Hrs left   = %.0f\n',b2(Z) - a21(Z)*X(1,Z) - a22(Z)*X(2,Z))
