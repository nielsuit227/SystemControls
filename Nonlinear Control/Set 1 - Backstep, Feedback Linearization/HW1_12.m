clear all
close all
clc
%% Exercise 12 Nonlinear Control homework 1
% parameters
sigma1 = 1;
sigma2 = 2;
a0 =2;
a1 = 2;
c1 = 2;
c2 = 2;
x0 = [1;-1;2];
t0 = 0;
tend = 15;
tspan = [t0 tend];
%% Backstep 4
[tbs4,xbs4] = ode45(@(t,x) backstep4(t,x,sigma1,c1,c2),tspan,x0);
figure
plot(tbs4,xbs4(:,1))
hold on
plot(tbs4,xbs4(:,2))
plot(tbs4,xbs4(:,3))
legend('State1','State2','State3')
title('Backstepping (Ex. 4)')
%% Backstep 6
[tbs6,xbs6]  = ode45(@(t,x) backstep6(t,x,sigma1,c1,c2),tspan,x0);
figure
plot(tbs6,xbs6(:,1))
hold on
plot(tbs6,xbs6(:,2))
plot(tbs6,xbs6(:,3))
legend('State1','State2','State3')
title('Backstepping (Ex. 6)')
%% Exercise 13
[t1,x1] = ode45(@(t,x) IOlin(t,x,sigma1,a0,a1),tspan,x0);
[t2,x2] = ode45(@(t,x) IOlinsig2(t,x,sigma1,sigma2,a0,a1),tspan,x0);
figure
plot(t1,x1(:,1),'r',t1,x1(:,2),'r',t1,x1(:,3),'r')
hold on
plot(t2,x2(:,1),'b',t2,x2(:,2),'b',t2,x2(:,3),'b')
title('State response for Feedback Linearization')
legend('State 1','State 2','State 3','Wrong theta x1','Wrong theta x2','Wrong theta x3')
%% Controller comparison
figure
plot(tbs4,xbs4(:,2))
hold on
plot(tbs6,xbs6(:,2))
plot(t1,x1(:,2))
legend('Backstepping Ex.4','Backstepping Ex.6','Feedback Linearization')
