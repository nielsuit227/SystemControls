clear
close all
clc
%% Loading
load('U_id.mat')
U = data.Data;
load('Y_id.mat')
Y = data.Data;
T = data.Time;
s = min(length(Y),length(U));
U = U(1:s); Y=Y(1:s); T=T(1:s);
%% Selecting
h = 0.01;
s = 10;
n = 4;
t1 = 25;
t2 = 150;
Y_id = Y(t1/h:t2/h);
U_id = U(t1/h:t2/h);
T_id = T(t1/h:t2/h);
DAT = iddata(Y_id,U_id,h);
%%
load('U_id2.mat')
U = data.Data;
load('Y_id2.mat')
Y = data.Data;
T = data.Time;
s = min(length(Y),length(U));
U = U(1:s); Y=Y(1:s); T=T(1:s);
DAT2 = iddata(Y,U,0.001);
%%
plot(T,U,T,Y)	
%% Selecting
h = 0.001;
s = 10;
n = 4;
t1 = 25;
t2 = 150;
Y_id2 = Y(t1/h:t2/h);
U_id2 = U(t1/h:t2/h);
T_id2 = T(t1/h:t2/h);


%% NASID
optCVA = n4sidOptions('N4weight','CVA');
optSSARX = n4sidOptions('N4weight','SSARX');
sys_CVA = n4sid(DAT,n,optCVA);
sys_SSARX = n4sid(DAT,n,optSSARX);
%% Check
obsCVA = []; conCVA = []; obsSSARX = []; conSSARX = [];
for i=1:n
    obsCVA = [obsCVA;sys_CVA.C*sys_CVA.A^(i-1)];
    obsSSARX = [obsSSARX;sys_SSARX.C*sys_SSARX.A^(i-1)];
    conCVA = [conCVA sys_CVA.A^(i-1)*sys_CVA.B];
    conSSARX = [conSSARX sys_SSARX.A^(i-1)*sys_SSARX.B];
end
if rank(obsCVA) ~= n || rank(obsSSARX) ~= n
    error('System not Observable')
elseif rank(conCVA) ~= n || rank(conSSARX) ~= n
    error('System not Controllable')
else
    fprintf('System Identification Complete\n')
end
%% Results
compare(DAT,sys_CVA)
axis([0,150,-0.1,0.1])
%%
Y_sim = lsim(ss(ss3),U_id,T_id);
%%
figure
plot(T_id,Y_sim,T_id,Y_id)
axis([40,40.1,-0.1,0.1])