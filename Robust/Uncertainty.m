clear; close all; clc;
k = ureal('k',0.5,'range',[0.4 0.6]);
alpha = ureal('alpha',0.1,'range',[0.8 1.2]);
A = [-(1+k) 0;1 -(1+k)];
B = [(1-k)/k;-1];
C = [0 alpha];
D = 0;
Gp = ss(A,B,C,D)
bode(Gp)