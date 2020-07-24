%%% Non linear optimization together with Oscar de Groot (353). Optimizing
%%% the flow of the on ramp for a highway with 4 segments to minimise the
%%% total time spend on the highway. The states chosen are the car
%%% densities on each segment, the mean velocities of each segment and the
%%% waiting queue for the only on ramp of the system in segment 4. Initials
%%% are determined by the assignment and the student numbers.
clear
close all
clc
global nlc t_it
%% Chose Non Linear constraint, Optimization method and initial r.
nlc = 0;
sqp = 0;
GA = 0;
ip = 1;
r0 = 0;
%% Parameters
tau     = 10/3600;                   % [s]
T       = 600/3600;                  % [s]
steps   = round(T/tau);
%% Initials
q0 = 60;
r0 = r0*ones(steps,1);
%% Constraints
rl = 0*ones(steps,1);
ru = 1*ones(steps,1);
%% Sequential Quadratic Programming
if sqp == 1
optionssqp = optimoptions('fmincon', 'Algorithm', 'sqp','MaxIterations',10000,'MaxFunctionEvaluations',100000,'PlotFcn',@optimplotx);
tic;
[r_sqp,FVAL,FLAG,ITERATION] = fmincon(@Costf,r0,[],[],[],[],rl,ru,[],optionssqp);
t_int = toc;
fprintf('SQP duration: %.3f s\n', t_int);
simulate(r_sqp)
end
%% Generic Algorithm
if GA == 1
optionsga = gaoptimset('Generations', 500, 'Display', 'off','PlotFcns',@gaplotselection);
tic;
[r_ga,FVAL,FLAG,ITERATION] = ga(@Costf,steps,[],[],[],[],rl,ru, [], optionsga);
t_int = toc;
fprintf('GA duration: %.3f s\n', t_int);
simulate(r_ga)
end
%% Interior Point
if ip == 1
optionsip = optimoptions('fmincon', 'Algorithm','interior-point', 'MaxFunEvals', 100000, 'MaxIter', 2000,'PlotFcn',@optimplotx);
tic;
[r_ip, FVAL,FLAG,ITERATION] = fmincon(@Costf, r0, [], [], [], [], rl, ru, [], optionsip);
t_int = toc;
fprintf('IP duration: %.3f s\n', t_int);
simulate(r_ip);
end