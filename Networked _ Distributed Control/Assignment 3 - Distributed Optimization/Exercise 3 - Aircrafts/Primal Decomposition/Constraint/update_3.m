function [U3,s3,s4,s5,s6] = update_3(L)
global umax Tfinal X B A
%% Define agent
i=3;
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
s3 = - X5;
s4 = -s3;
s5 = -s3;
s6 = s3;
fun = X_sum + U_sum + s3'*L(:,3) + s4'*L(:,4) + s5'*L(:,5) + s6'*L(:,6);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%% DIFFERENT FOR EACH AGENT %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Solve and return
sol = optimize(cons,fun,opts);

if sol.problem ~= 0
    warning('Error %.0f in Optimization 3',sol.problem)
end
U3 = value(U);
end