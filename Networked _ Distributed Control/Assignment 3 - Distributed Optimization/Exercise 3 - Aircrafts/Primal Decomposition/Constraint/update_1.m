function [U1,s1,s2] = update_1(L)
global umax Tfinal X B A
%% Define agent
i=1;
%% Loading data
At = A(:,:,i);
Bt = B(:,:,i);
%% Optimization settings
U = sdpvar(2,Tfinal);
cons = sum(sum(U.^2)) <= umax;
opts = sdpsettings('verbose',0);
%% Creating Sums
X0 = X(:,1,i);
X1 = At*X0 + Bt*U(:,1);
X2 = At*X1 + Bt*U(:,2);
X3 = At*X2 + Bt*U(:,3);
X4 = At*X3 + Bt*U(:,4);
X5 = At*X4 + Bt*U(:,5);
X_sum = X0'*X0 + X1'*X1 + X2'*X2 + X3'*X3 + X4'*X4 + X5'*X5;
U_sum = U(:,1)'*U(:,1) + U(:,2)'*U(:,2) + U(:,3)'*U(:,3) + U(:,4)'*U(:,4) + U(:,5)'*U(:,5);
%% Creating Cost fun 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% DIFFERENT FOR EACH AGENT %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s1 = X5;
s2 = -s1;
fun = X_sum + U_sum + L(:,1)'*s1 + L(:,2)'*s2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% DIFFERENT FOR EACH AGENT %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Solve and return
sol = optimize(cons,fun,opts);
U1 = value(U);
if sol.problem ~= 0
    warning('Error %.0f in Optimization 1',sol.problem)
end
end