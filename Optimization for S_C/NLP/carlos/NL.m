clear all;
clc;
close all;
format shortG;
global tIt
tIt = 0;
%% Calculations
options = optimoptions('fmincon', 'Algorithm', 'sqp', 'MaxFunEvals', 100000);
r0 = ones(60,1) * 0;

%optionsga = gaoptimset('Generations', 100);
%r = ga(@fun, 60, [], [], [], [], zeros(60,1), ones(60,1), [], optionsga);

[r,fval,exitflag,output] = fmincon(@fun, r0, [], [], [], [], zeros(60,1), ones(60,1), [], options);
%r = fmincon(@fun, r, [], [], [], [], zeros(60,1), ones(60,1), [], options);
%r = fmincon(@fun, r, [], [], [], [], zeros(60,1), ones(60,1), [], options);
simulate(r);
fprintf('Average Iteration Time: %.3f ms \n', tIt / output.iterations * 1000);
