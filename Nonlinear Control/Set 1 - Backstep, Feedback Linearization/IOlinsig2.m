function dx = IOlinsig2(t,x,sigma1,sigma2,a0,a1)
% This function computes the closed loop dynamics of the system with a
% controller using input-output linearization. Here we assume we don't know
% the correct sigma. 
% input: t,x (3x1), sigma, a0, a1
% output: dx

% System
f = [(1/2)*x(1)*sigma2*(1-(x(2)+1)^2-x(1)^2);
    x(3)+1/2+(3/2)*x(2)-(1/2)*(x(2)+1)^3-3*(x(2)+1)*x(1)^2;
    0];
g = [0;0;1];

%controller calculations
h = [-6*(x(2)+1)*x(1), (3/2)-(3/2)*(x(2)+1)^2-3*x(1)^2, 1];
L2f = h*[(1/2)*x(1)*sigma1*(1-(x(2)+1)^2-x(1)^2);
    x(3)+1/2+(3/2)*x(2)-(1/2)*(x(2)+1)^3-3*(x(2)+1)*x(1)^2;
    0];
y = x(2);
dy = f(2);

%virtual controller
v = -a0*y-a1*dy;

dx = f +g*(-L2f+v);