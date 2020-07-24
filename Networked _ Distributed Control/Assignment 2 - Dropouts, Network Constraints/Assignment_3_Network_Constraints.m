close all
clear
clc
%% System
Ac = 2;
Bc = 1/2;
C = 1;
K = -6;
%% Extended state - Robin Round Protocol
% A1 = Gamma_u = 1 (Gamma_y = 0)
% A0 = Gamma_y = 1 (Gamma_u = 0)
step = 0.001;
max = 0.25;
stab = zeros(max/step,1);
for h=step:step:max
    A = exp(Ac*h);
    B = Ac\(A-1)*Bc;
    A1 = [A B*K 0;
            0 1 0;
                0 K 0];
    A0 = [A 0 B;
            C 0 0;
              0 0 1];
    if any(abs(eig(A0*A1))>=1)
        h_rr = h;
        fprintf('Max sampling interval for RR is %.3fs\n\n',h)
        break
    end
end
%% Extended state - Stochastic Protocol
p0 = 0.5;
ops = sdpsettings('solver','sedumi','verbose',0);
Q = eye(3)*1e-3;
obj = 0;
for h=step:step:max
    A = exp(Ac*h);
    B = Ac\(A-1)*Bc;
    A1 = [A B*K 0;
            0 1 0;
                0 K 0];
    A0 = [A 0 B;
            C 0 0;
              0 0 1];
    
    P = sdpvar(3,3);
    cons = [];
    cons = [cons, P >= Q];
    cons = [cons, trace(P) == 1];
    cons = [cons, p0*A0'*P*A0 + (1-p0)*A1'*P*A1 <= P];
    res = optimize(cons,obj,ops);
    if res.problem ~= 0 && res.problem ~= 4
        
        fprintf('Max sampling interval for SP is %.3fs\n%.0f\n',h,res.problem)
        h_sp = h;
        break
    end
end

