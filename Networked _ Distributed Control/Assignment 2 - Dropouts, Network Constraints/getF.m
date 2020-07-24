function [Hf1, Hf2, Hf3, Hf4, Hg1, Hg2, Hg3, Hg4] = getF(A,h,ami1,ami2,ama1,ama2,t)
expAh = expm(A*h);
%% Split matrix (based on dependence on Tau_k) 
% F0, G0 are not dependent on tau_k. 
% F1, G1 are dependent on exp(lambda1(h-tau_k)).
% F2, G2 are dependent on exp(lambda2(h-tau_k)).
F0 = [expAh [5/2772*exp(72*h)-100/2079*exp(2.7*h);1/2.7*exp(2.7*h)];zeros(1,3)];
F1 = zeros(3,3); F1(1,3) = -5/2772;
F2 = zeros(3,3); F2(1:2,3) = [100/2079;-1/2.7]; %100/2079
G0 = [9/194.4;-1/2.7;1];
G1 = [1/(7.7*72);0;0];
G2 = [-1/7.7/72-9/194.4;1/2.7;0];
%% Uncertain set definition
Hf1 = F0 + ami1*F1 + ami2*F2;
Hg1 = G0 + ami1*G1 + ami2*G2;
Hf2 = F0 + ami1*F1 + ama2*F2;
Hg2 = G0 + ami1*G1 + ama2*G2;
Hf3 = F0 + ama1*F1 + ami2*F2;
Hg3 = G0 + ama1*G1 + ami2*G2;
Hf4 = F0 + ama1*F1 + ama2*F2;
Hg4 = G0 + ama1*G1 + ama2*G2;
end