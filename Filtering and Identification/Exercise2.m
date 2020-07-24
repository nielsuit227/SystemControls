%%% Matlab exercise 2 for SC40025 Filtering and Control by Niels Uitterdijk
%%% December 2017. This script uses two functions that transform
%%% input/output data to either a state space system or an ARX system. 
close all
clear
clc
load('Homework.mat')
%% 3.1 Check which sets are useful
% The UosN matrix of dataset 0, 1 and 4 are full rank. As by definition
% 10.1 these are the useful datasets. 
%% 3.2 Which model order n and how s should be chosen?
% It is obvious that the order of system s should be taken large enough to have a state space
% representation of the data. Also, s defines the length of one sequence or column size of
% the Hankel matrices. N represents the amount of columns in the Hankel
% matrices and it is necessary to have n < s << N. Here n is the order of
% the actual system, s the order of the identified system and N the amount
% of columns used to get the identified system. 
%% 3.3 Why is it useful to have the singular values of YP as output of mysubid
% With the singular values you can check the order of the system and
% therefor see if you've chosen s,n and N wisely. 
%% 3.4 Use both your functions to identify a 6th order model of the system for the two suitable sets of data
[Aest1 Best1] = myarx(y1,u1,6);
[Aest4 Best4] = myarx(y4,u4,6);
[At1 Bt1 Ct1 Dt1 x0t1 S1] = mysubid(y1,u1,12,6);
[At4 Bt4 Ct4 Dt4 x0t4 S4] = mysubid(y4,u4,12,6);
%% 3.5 Compare the bode plots to the real tf tfse
sys1si = ss(At1,Bt1,Ct1,Dt1,-1);
sys4si = ss(At4,Bt4,Ct4,Dt4,-1);
sys1arx = tf(Best1',Aest4',-1);
sys4arx = tf(Best4',Aest4',-1);
subplot(1,2,1)
bode(tfse)
hold on
bode(sys1si)
bode(sys1arx)
legend('Original system','Subspace Identification','ARX')
subplot(1,2,2)
bode(tfse)
hold on
bode(sys4si)
bode(sys4arx)
legend('Original system','Subspace Identification','ARX')
%% 4.1 Estimate the order of the system
% The order of the system can be estimated by looking at the singular
% values of the SVD. The order of dataset0 turns out to be 2.
[At0 Bt0 Ct0 Dt0 x0t0 S0] = mysubid(y0,u0,25,6);
figure
plot(S0,'o')
%% 4.2 Biase dataset 0 and recheck the order of the system. 
% By switching the data the rank of the system has become 3. Somehow an additional 
% state is necessary to achieve the behaviour of y. 
y00 = y0 + 0.2;
[At00 Bt00 Ct00 Dt00 x0t00 S00] = mysubid(y00,u0,25,3);
%% 4.3 Is the 00 system reachable and where are its poles?
% Getting the transferfuntion of the state space system gives the poles,
% which are located at 1,0.4414,0.1586. 
% Checking the reachability with the reachability matrix confirms that the
% system is not reachable as it is not full rank. 
sys = ss(At00,Bt00,Ct00,Dt00);
H = tf(sys);
p = pole(H);
Wt = [];
for n=1:6
    Wt = [At00^(n-1)*Bt00 Wt];
end