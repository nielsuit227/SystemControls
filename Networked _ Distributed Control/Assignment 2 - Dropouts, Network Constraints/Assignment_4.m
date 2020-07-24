clear
close all
clc
%% CT Pole-placement
A = [72 9;0 2.7];
e=eig(A);
B = [0;1];
p = [-2,-2];
K = acker(A,B,p);
K = [K 0];
%% Stability for different varying delays and fixed sampling intervals
hmax = 0.05;
hstep = 100;
tstep = 100;
retry = 10;
stab = zeros(hstep,tstep);

Q = eye(3)*1e-2;
y = linspace(0.005,0.00005,retry+1);
obj = 0;
ops = sdpsettings('solver','sedumi','verbose',0);
for h = 0:hmax/hstep:hmax
    for t = 0:hmax/tstep:hmax
        res.problem = 4;
        hi = uint16(h/hmax*hstep+1);
        ti = uint16(t/hmax*tstep+1);
        c = 0;
        if h >= t    
            while res.problem ~= 0 && c < retry+1
                c = c+1;
            
                alpha_1_min = exp(e(1)*(h-t));
                alpha_2_min = exp(e(2)*(h-t));
                alpha_1_max = exp(e(1)*h);
                alpha_2_max = exp(e(2)*h);
                [Hf1, Hf2, Hf3, Hf4, Hg1, Hg2, Hg3, Hg4] = getF(A,h,alpha_1_min,alpha_2_min,alpha_1_max,alpha_2_max,t);
          
                P = sdpvar(3,3);
                cons=[];
                cons = [cons, P >= zeros(3,3)];
%             cons = [cons, trace(P) == 1];
                cons = [cons, (Hf1 - Hg1*K)'*P*(Hf1 - Hg1*K) - P <= -y(c)*P+Q];
                cons = [cons, (Hf2 - Hg2*K)'*P*(Hf2 - Hg2*K) - P <= -y(c)*P+Q];
                cons = [cons, (Hf3 - Hg3*K)'*P*(Hf3 - Hg3*K) - P <= -y(c)*P+Q];
                cons = [cons, (Hf4 - Hg4*K)'*P*(Hf4 - Hg4*K) - P <= -y(c)*P+Q];
                res = optimize(cons,obj,ops);
                if res.problem ~= 0 && res.problem ~= 4
                    stab(ti,hi) = 1;
                elseif res.problem == 4
                    stab(ti,hi) = -1;
                end
            end
        else
            stab(ti,hi) = -2;
        end
    end
    clc
    fprintf('%.0f /100',h*100/hmax)
end
%% Plot results
figure
li = linspace(0,hmax*1000,hstep);
imagesc(li,li,stab)
set(gca,'YDir','normal')
ylabel('\tau_{max} [ms]')
xlabel('Sampling interval [ms]')
        