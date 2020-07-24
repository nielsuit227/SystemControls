%%% Simulate a non-autonomous scalar dynamics and analyse the
%%% unboundedness.
close all
clear
clc
%% Inititals
d = 1;
a = 5;
%% System
dx = @(x,t) -x + d*sin(t);
x(1) = a;
for n=1:10
    x(n+1) = x(n) + dx(x(n),n);
end
%% Show results
figure
plot(x)
%% Show bounds
i = linspace(d,d,n+1);
ii = linspace(-d,-d,n+1);
hold on
plot(i,'r')
plot(ii,'r')
xlabel('Time steps')
ylabel('State')