%%% Adaptive controller
clear
clc
close all
%% Inititals
samples = 1000;
a = 1;
b = 2;
y = 5;
x(1) = 5;
k(1) = 1;
r = zeros(samples,1);
r(ceil(samples/2):samples,1) = 5;
dt = 1/samples;
t(1) = 0;
%% Loop
for n=1:samples-1
    a(n+1) = a(n) + dt*50*(2 - randi(3));
    x(n+1) = x(n) + dt*(a(n)-k(n))*(x(n)-r(n));
    k(n+1) = k(n) + dt*y*(r(n)-x(n))^2;
    t(n+1) = t(n) + dt;
end
%% Plot
figure
plot(t,r)
hold on
plot(t,x)
plot(t,k)
plot(t,a)
legend('Reference','State','Adaptive Gain','Parameter a')
%% Gamma sensitivity
y = [1;5;10];
for m=1:3
   %% Loop
for n=1:samples-1
    a(n+1) = a(n) + dt*25*(2-randi(3));
    x(n+1,m) = x(n,m) + dt*(a(n)-k(n,m))*(x(n,m)-r(n));
    k(n+1,m) = k(n,m) + dt*y(m)*(r(n)-x(n,m))^2;
end 
end
figure
plot(t,x(:,1),t,x(:,2),t,x(:,3))
hold on
ax = gca;
ax.ColorOrderIndex = 1;
plot(t,r,'k')
plot(t,k(:,1),t,k(:,2),t,k(:,3))
legend('Gamma = 1','Gamma = 5','Gamma = 10')
%0.9290    0.6940    0.1250


