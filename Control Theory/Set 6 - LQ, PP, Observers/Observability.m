%% Init
clear
close all
clc
%% 1.A
fprintf('1.A\n')
A = [0 -1 -1 0 0 ; 0 -1 0 0 0; 0 -1 -1 0 0; 0 -0.1 -2 0 -0.1; 0 1 2 0 -0.2];
C1 = [1 0 0 0 0; 0 0 0 1 0];
C2 = [0 0 1 0 0; 0 0 0 0 1];
C3 = [0 0 1 0 0; 0 0 0 1 0; 0 0 0 0 1];
l1 = 0;
l2 = -1;
l3 = -0.2;
R11 = rank(rref([A-l1*eye(5);C1]));
R21 = rank(rref([A-l2*eye(5);C1]));
R31 = rank(rref([A-l3*eye(5);C1]));
R12 = rank(rref([A-l1*eye(5);C2]));
R22 = rank(rref([A-l2*eye(5);C2]));
R32 = rank(rref([A-l3*eye(5);C2]));
R13 = rank(rref([A-l1*eye(5);C3]));
R23 = rank(rref([A-l2*eye(5);C3]));
R33 = rank(rref([A-l3*eye(5);C3]));

if R11==R21 && R31 == 5 && R31 == R21
    fprintf('For C1 Observable\n')
end
if R12==R22 && R32==5 && R32 == R22
    fprintf('For C2 Observable\n')
end
if R13==R23 && R33 == 5 && R33 == R23
    fprintf('For L3 Observable\n')
end
