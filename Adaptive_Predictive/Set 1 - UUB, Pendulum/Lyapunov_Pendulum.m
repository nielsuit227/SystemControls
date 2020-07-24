%%% Simulate a non-autonomous scalar dynamics and analyse the
%%% unboundedness.
close all
clear
clc
%% Inititals
a = 2;
b = 0.3;
dt = 0.01;
%% System
dx1 = @(x2) x2;
dx2 = @(x1,x2) -a*sin(x1) - b*x2;
x1(1) = pi/2;
x2(1) = 0;
V1(1) = a*sin(x1(1));
intV1(1) = dt*V1(1);
for n=1:2000
    x1(n+1) = x1(n) + dt*dx1(x2(n));
    x2(n+1) = x2(n) + dt*dx2(x1(n),x2(n));    
    V1(n+1) = a*sin(x1(n+1));
    intV1(n+1) = intV1(n) + V1(n+1)*dt;
    V(n) = intV1(n) + 1/2*x2(n)^2;
end
%% Show results
plot(x1,x2)
figure
data = [x1' x2'];
N=numel(data(:,1));
for a=1:N-1
    plot(data(a:a+1,1),data(a:a+1,2),'-','Color',[(a/numel(data(:,1))),0,0] ); 
    hold on 
end
%axis([-1.5 1.5 -2 2])
xlabel('x1')
ylabel('x2')
figure
plot(V)