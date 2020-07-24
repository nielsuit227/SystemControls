%%% RGA shows how strongly a MIMO system is coupled. It differs for
%%% different frequencies. Below is the RGA for two SISO systems without
%%% coupling calculated. The Lambda equals to 1, meaning no coupling.
%%% Lambda equals to 0 is fully other way around coupled. 
%% Two random systems
n=1;
A1 = randi(10,n,n);
B1 = randi(10,n,n);
C1 = randi(10,n,n);
D1 = randi(10,n,n);
A2 = randi(10,n,n);
B2 = randi(10,n,n);
C2 = randi(10,n,n);
D2 = randi(10,n,n);
%% Coupled System with RGA = 1
v = zeros(n,n);
A = [A1 v;v A2];
B = [B1 v;v B2];
C = [C1 v;v C2];
D = [D1 v;v D2];
%% Calc RGA
Gtf = tf(ss(A,B,C,D));
RGA = Gtf.*inv(Gtf)';
Gtf2_0 = evalfr(Gtf,0);
Gtf2_03Hz = evalfr(Gtf,0.6*pi);
RGA_0 = inv(Gtf2_0)'.*Gtf2_0;
RGA_03Hz = inv(Gtf2_03Hz)'.*Gtf2_03Hz;
% Both values give Lambda = 1, which corresponds to a none decoupled
% system. 
