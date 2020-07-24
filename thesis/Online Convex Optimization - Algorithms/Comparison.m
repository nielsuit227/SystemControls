clear
close all
clc

%% Startup
syms x
f = @(x) (20-x).^2+15*x;
df = eval(['@(x)' char(diff(f(x)))])
xg = 30;
xr = 30;
plot(xg, f(xg), 'r*')
hold on
plot(xr, f(xr), 'b*')
fplot(f, [-20, 30], 'k-')
title('Optimization comparison, blue=RFTL, red=GD')
%% Optimization
sgr = 0;
g = 0.8;
while(1)
    pause(1)
    xg = xg - g*df(xg)
    sgr = sgr + df(xr);
    xr = -0.5*sgr*g       % squared 2-norm regularizer
    plot(xg, f(xg), 'r*')
    plot(xr, f(xr), 'b*')
    if abs(df(xr)) < 0.1 && abs(df(xg)) < 0.1
        break
    end
end
    



