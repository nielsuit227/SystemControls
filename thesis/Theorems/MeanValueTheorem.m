%%% Proof and show of the Mean Value Theorem. Regardless of the function,
%%% the difference at two points is always presence between those two
%%% points. (if the function is smooth)
clear
close all 
clc
set(0, 'DefaultLineLineWidth', 2);
syms x
%% Define function
y = sin(x)^2 - x^3 + 1/2*(x-6)^2 - 40*x - exp(x);
fdy = diff(y,x);
%% Define interval
x1 = -5;
x2 = 5;
%% Define two points
subplot(2,1,1)
fplot(y,[x1 x2]); hold on; title('Function and approximated derivative')
x1 = 0.9*x1; x2 = 0.9*x2; 
plot([x1 x1],[-15000 25000],'k')
plot([x2 x2],[-15000 25000],'k')
%% Derivative
x = x1; y1 = single(subs(y)); x = x2; y2 = single(subs(y));
dy = (y2-y1)/(x2-x1);
syms x;
fplot(dy*x+y1-dy*x1)
axis([x1/0.9 x2/0.9 1.1*min(y1,y2) 1.1*max(y1,y2)])
%% Plot derivative
subplot(2,1,2)
fplot(fdy); hold on; title('Actual and approximated derivative')
plot([x1/0.9 x2/0.9],[dy dy])