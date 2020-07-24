function stab = evalstab(h,Adt)
n = size(Adt,1);
eps = 1e-3;
%% Determine stability
P = sdpvar(n,n);
Q = eps*eye(n);
cons = [];
cons = [cons, P>=eps*eye(n)];
for ii = 1:length(h)
    cons = [cons, Adt(:,:,ii)'*P*Adt(:,:,ii) - P <= -Q];
end
ops = sdpsettings('solver','sedumi','verbose',0);
obj = 0;
res = optimize(cons,obj,ops);
Pf = value(P);
stab = 1;
for ii=1:length(h)
    clc
    e = eig(Adt(:,:,ii)'*Pf*Adt(:,:,ii) - Pf);
    max(e)
    pause(1)
    if e(1) >= -eps || e(2) >= -eps || res.problem ~= 0
        stab = 0;
        return
    end
end

