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
    alpha = 0.5 - 0.49/iterations*i;
    [U1,X1f] = update_1(L); %fprintf('Control 1 done\n')
    [U2,X2f] = update_2(L); %fprintf('Control 2 done\n')
    [U3,X3f] = update_3(L); %fprintf('Control 3 done\n')
    [U4,X4f] = update_4(L); %fprintf('Control 4 done\n')
    L(:,1) = L(:,1) + alpha*(X1f-X2f);
    L(:,2) = L(:,2) + alpha*(X1f-X3f);
    L(:,3) = L(:,3) + alpha*(X1f-X4f);
    L(:,4) = L(:,4) + alpha*(X2f-X3f);
    L(:,5) = L(:,5) + alpha*(X2f-X4f);
    L(:,6) = L(:,6) + alpha*(X3f-X4f);
    clc
    fprintf('%.2f%% done\n\n',i/iterations*100)
    Xf(:,i) = mean([X1f X2f X3f X4f],2);
    e(i) = sum(sum((X1f-Xf).^2)+sum((X2f-Xf).^2)+sum((X3f-Xf).^2)+sum((X4f-Xf).^2));
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
figure
plot(e)


