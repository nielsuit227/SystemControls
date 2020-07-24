function [U4,s5,s6,s7] = update_4(L,L7)
global umax Tfinal X B A
%% Define agent
i=4;
%% Loading data
At = A(:,:,i);
Bt = B(:,:,i);
%% Optimization settings
U = sdpvar(2,Tfinal);
cons = sum(sum(U.^2)) <= umax;
cons2 = sum(sum(U.^2)) <= 10*umax;
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
s5 = -X5;
s6 = -s5;
s7 = sum(sum(U.^2)) - umax;
fun = X_sum + U_sum + s5'*L(:,5) + s6'*L(:,6);
fun2 = X_sum + U_sum + s5'*L(:,5) + s6'*L(:,6) + s7*L7;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% DIFFERENT FOR EACH AGENT %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Solve and return
sol = optimize(cons,fun,opts);
% sol = optimize(cons2,fun2,opts);
U4 = value(U);
if sol.problem ~= 0
    warning('Error %.0f in Optimization 4',sol.problem)
end
end