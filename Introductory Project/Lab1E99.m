clc
close all
clear
w = 4*pi;
syms kv kp
[kv kp] = solve(1 == sqrt((1400*pi*w)^2+(1400*pi*kp/kv)^2)/sqrt(w^4+(140*pi*w)^2), 225/360*2*pi == atan(w*kv/kp) - atan(-140*pi/w),kv,kp);
kv = double(kv)
kp = double(kp)