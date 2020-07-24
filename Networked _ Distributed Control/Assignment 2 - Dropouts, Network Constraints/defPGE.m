function [p] = defPGE(A1,A0)
n = size(A1,1);
eps = 1e-3;

Q = eps*eye(n);

ops = sdpsettings('solver','sedumi','verbose',0);
obj = 0;
global s
s = 10;
for i = 0:1/s:1
    for ii = 0:1/s:1
        p11 = i;
        p00 = ii;
        P1 = sdpvar(n,n);
        P0 = sdpvar(n,n);
        cons = [];
        cons = [cons, P0 >= Q];
        cons = [cons, P1 >= Q];
        cons = [cons, trace(P0) == 1];
        cons = [cons, trace(P1) == 1];
        cons = [cons, p00*A0'*P0*A0 + (1-p00)*A1'*P1*A1 <= P0];
        cons = [cons, (1-p11)*A0'*P0*A0 + p11*A1'*P1*A1 <= P1];
        res = optimize(cons,obj,ops);
        if res.problem ~= 0
            p(uint16(i*s+1),uint16(ii*s+1)) = 1;
        end
    end
    clc
    fprintf('%.0f',i*100)
end
