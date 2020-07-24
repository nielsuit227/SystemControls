%%% First script to test hypothesis about the projection from any alpha to
%%% sum_i(alpha_i * y_i) = 0. Will be used to implement OCO into SVM. 
clear
close all
clc
%% Generate data
n = 50;
A = rand(n,1);
Y = randi(2,n,1); Y(Y==2) = -1;
sum(A.*Y)
figure
f = @(x) x; fplot(f,[0,n]); hold on;
plot(sum(A(Y==1)),sum(A(Y==-1)),'k*');
%% Projection
% We acquire the total and project it onto y = x (which will make the sum
% zero). 
Ap = sum(A(Y==1));          % Total of positive multipliers
An = sum(A(Y==-1));         % Total of negative multipliers
As = (Ap+An)/2;             % Scaling variable
A(Y==1) = A(Y==1)/Ap*As;    % Projected positive variables
A(Y==-1) = A(Y==-1)/An*As;  % Projected negative variables
sum(A.*Y)
plot(sum(A(Y==1)),sum(A(Y==-1)),'b*')
legend('Constraint','Original','Projected')
axis equal