choice = menu('You sure you want to simulate EVERYTHING?','Obviously not,just want to plot','Oh yes please')
if choice == 2
clear 
close all
clc
%% 
load('SUB88.mat')
compare(DAT,ss3)
x = 10000;
Y = DAT.OutputData(1:x);
U = DAT.InputData(1:x);
%% Controller
F = place(ss3.A,ss3.B,[.9 .91 .92 .93 .96 .98]);
L = place(ss3.A',ss3.C',[.2 .3 .25 .22 .27 .29])';
L2 = place(ss3.A',ss3.C',[.4 .5 .45 .47 .49 .52])';
%% Sim init
t = 0;
h = 0.01;
X_con = zeros(6,length(Y));
X_con(:,1) = ss3.x0;
X_es = zeros(6,length(Y));
X_es(:,1) = ss3.x0;
X_es2 = zeros(6,length(Y));
X_es2(:,1) = ss3.x0;
X_sim = zeros(6,length(Y));
X_sim(:,1) = ss3.x0;
Y_con = zeros(length(Y),1);
Y_es = zeros(length(Y),1);
Y_sim = zeros(length(Y),1);
%% Sim
for n=1:length(U)
    t(n+1) = t(n) + h;
    %% Using the Observer and Controller
    Y_con(n) = ss3.C*X_con(:,n);
    X_con(:,n+1) = (ss3.A - ss3.B*F) * X_con(:,n) + L*(DAT.OutputData(n) - Y_con(n));
    %% Using just the estimation
    Y_es(n) = ss3.C*X_es(:,n);
    X_es(:,n+1) = ss3.A*X_es(:,n) + ss3.B*U(n) + L*(Y(n) - Y_es(n));
    %% Using just the estimation
    Y_es2(n) = ss3.C*X_es2(:,n);
    X_es2(:,n+1) = ss3.A*X_es2(:,n) + ss3.B*U(n) + L2*(Y(n) - Y_es2(n));
    %% Validating the model
    Y_sim(n) = ss3.C*X_sim(:,n);
    X_sim(:,n+1) = ss3.A*X_sim(:,n) + ss3.B*DAT.InputData(n);
end
end
%% Process
figure
plot(DAT.OutputData);
hold on
plot(Y_sim)
title('Model')
figure
plot(DAT.OutputData);
    %% Using just the estimation
    Y_es(n) = ss3.C*X_es(:,n);
    X_es(:,n+1) = ss3.A*X_es(:,n) + ss3.B*U(n) + L*(Y(n) - Y_es(n));
hold on
plot(Y_es)
plot(Y_es2)
title('Observer')
figure
plot(DAT.OutputData);
hold on
plot(Y_con)
title('Controller')