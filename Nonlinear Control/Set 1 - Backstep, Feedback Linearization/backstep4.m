function dx = backstep4(t,x,sigma,c1,c2)
% input: t,x (3x1), sigma,c
% output: dx
%% System
f = [(1/2)*x(1)*sigma*(1-(x(2)+1)^2-x(1)^2);
    x(3)+1/2+(3/2)*x(2)-(1/2)*(x(2)+1)^3-3*(x(2)+1)*x(1)^2;
    0];
g = [0;0;1];

%% controller
dalfa = - c1*f(2) + 3*x(2)*f(2) + 6*x(1)*f(1) + f(2)*x(1)^2 + 6*x(2)*x(1)*f(1) ;

u = -c2*x(2) + dalfa;

%% closed loop system

dx = f + g*u;