function [p] = defP(A1, A0)
n = size(A1,1);
eps = 1e-3;
%% Determine stability
Q = eps*eye(n);
ops = sdpsettings('solver','sedumi','verbose',0);
obj = 0;
s = 100;
for i = 0:1/s:1
    P = sdpvar(n,n);
    cons = [];
    cons = [cons, P >= Q];
    cons = [cons, trace(P) == 1];
    cons = [cons, (1-i)*A0'*P*A0 + (i)*A1'*P*A1 <= P];
    res = optimize(cons,obj,ops);
    Pf = value(P);
    if res.problem ~= 0 %|| det((1-i)*A0'*Pf*A0 + i*A1'*Pf*A1 -Pf) >= det(-Q)
        p = i-1/s;
        clc
        break
    else
        p = 0;
    end
    clc
    fprintf('%.0f',i*100)
end
clc
end

