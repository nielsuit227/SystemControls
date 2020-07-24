clear
close all
clc
%% Loading
load('HighIsTheNewLowIn.mat')
U_id_t = data.Data;
load('HighIsTheNewLowout.mat')
Y_id_t = data.Data;
%% Selecting
h = 0.001;
s = 10;
n = 6;
t1 = 30;
t2 = 30.1;
Y_id = Y_id_t(t1/h:t2/h);
U_id = U_id_t(t1/h:t2/h);
%% NASID
DAT = iddata(Y_id,U_id,h);
optCVA = n4sidOptions('N4weight','MOESP');
sys = n4sid(DAT,n,optCVA);
%% Check
obsCVA = []; conCVA = [];
for i=1:n
    obsCVA = [obsCVA;sys.C*sys.A^(i-1)];
    conCVA = [conCVA sys.A^(i-1)*sys.B];
end
if rank(obsCVA) ~= n
    error('System not Observable')
elseif rank(conCVA) ~= n
    error('System not Controllable')
else
    fprintf('System Identification Complete\n')
end
%% Results
compare(DAT,sys)
axis([0 0.1 -1 1])

x = sys.Report.Fit.MSE;  

