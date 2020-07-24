clear
close all
clc
Systems
%% Settings
global Tfinal A B X umax
iterations = 50;
convergence = 1e-3;
alpha = 0.1;
%% Initial
U = zeros(2,5,4);
L = ones(4,6); L7 = 1;
%% Dual Optimization Loop
for i = 1:iterations
    [U1,s11,s21] = update_1(L);
    [U2,s12,s22,s32,s42] = update_2(L);
    [U3,s33,s43,s53,s63] = update_3(L);
    [U4,s54,s64,s74] = update_4(L,L7);
    L(:,1) = L(:,1) + alpha*(s11+s12);
    L(:,2) = L(:,2) + alpha*(s21+s22);
    L(:,3) = L(:,3) + alpha*(s32+s33);
    L(:,4) = L(:,4) + alpha*(s43+s42);
    L(:,5) = L(:,5) + alpha*(s54+s53);
    L(:,6) = L(:,6) + alpha*(s64+s63);
    L7 = L7 + alpha*s74;
    clc
    fprintf('%.2f%% done\n\n',i/iterations*100)
end
%% Simulate
U = zeros(2,5,4);
U(:,:,1) = U1;
U(:,:,2) = U2;
U(:,:,3) = U3;
U(:,:,4) = U4;
for i = 1:Tfinal
    for a = 1:4
        X(:,i+1,a) = A(:,:,a)*X(:,i,a) + B(:,:,a)*U(:,i,a);
    end
end
%% Plot
results(X)

