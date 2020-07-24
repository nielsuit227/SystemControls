clear
close all
clc

A = tf(1, [1 2 1])+tf(1,[1 2]);
B = tf(1,[1 1]);
C = tf(1,[1 0]) + tf(1, [1 4 4]);
D = tf(1,[1,0]);

G = [A,B;C,D];

ss(G)