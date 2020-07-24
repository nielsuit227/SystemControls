clear all

%% System agents

%The leader
Am=[0 1;-(0.7)^2, 0];
Bm=[0;1];
Cm=eye(2);
Dm=[0;0];

%Other agents
A1=[0,1;-2,-1];
B1=[0;1];
C1=[1.5,1];

A2=[0,1;-2.5,-0.75];
B2=[0;1];
C2=[1, 0.5];

A3=[0,1;-2,-1.25];
B3=[0;1];
C3=[1, 1.25];

A4=[0,1;-1,-0.5];
B4=[0;1];
C4=[0.75, 0.75];

A5=[0,1;-1,-0.75];
B5=[0;1];
C5=[2, 1.5];

%% Initial conditions

x0m=[0;1];
x01=[-0.5;1];
x02=[0.5;-1];
x03=[1;0.5];
x04=[-1;-0.5];
x05=[0;0];

%% Homogeneous case

Adj=[0 1 1 1 0; 1 0 0 0 1; 1 0 0 1 1; 1 0 1 0 0; 0 1 1 0 0];
L=[1,[-1;0;0;0;0]';[-1;0;0;0;0],(diag([4 2 3 2 2])-Adj)];
Lnolead=L(2:end,2:end);
Lnolead(1,1)=Lnolead(1,1)-1;
lambda=eig(Lnolead);

F=[-10 -10];
A_sync=kron(eye(5),Am)+kron(Lnolead,Bm*F);
A_follow=kron(eye(6),Am)+kron(L,Bm*F);
A_follow(1:2,1:4)=[Am,zeros(2,2)];

%% Heterogeneous case
%% optimal state feedback

k1=Am(2,:)-A1(2,:);
k2=Am(2,:)-A2(2,:);
k3=Am(2,:)-A3(2,:);
k4=Am(2,:)-A4(2,:);
k5=Am(2,:)-A5(2,:);

l1=1; l2=1; l3=1; l4=1; l5=1; 

Aer=kron(L,eye(2));

%Aer(1:2,1:4)=zeros(2,4);%Only use for case without leader
%Aer(3:4,1:2)=zeros(2,2);%Only use for case without leader


%% Adaptive state feedback case
%% Ricatti solution

Q=-5*eye(2);
Fadapt=[-15 -25];
P=care(Am+lambda(2)*Bm*Fadapt,[0;0],-Q);
gamma=[50 50;50 50; 50 50; 50 50; 100 100]';

for i=3:5
    T=P*(Am+lambda(i)*Bm*Fadapt)+transpose(Am+lambda(i)*Bm*Fadapt)*P;
    if (T(1,1)>=0 || det(-T)<=0)
        wrongeigenvalue=i
        error('Synchronization does not hold for all eigenvalues')
    end 
end

%% MRAC-output feedback

A1obs=[0 -2;1 -1];
B1obs=[1.5;1];
C1obs=[0 1];

A2obs=[0 -2.5;1 -0.5];
B2obs=[1;0.5];
C2obs=[0 1];

A3obs=[0 -2;1 -1.25];
B3obs=[1;1.25];
C3obs=[0 1];

A4obs=[0 -1;1 -0.5];
B4obs=[0.75;0.75];
C4obs=[0 1];

A5obs=[0 -1;1 -0.75];
B5obs=[2;1.5];
C5obs=[0 1];

Filterpole=-1;
MRACgam1=2000;
MRACgam2=2000;
MRACgam3=2000;
MRACgam4=2000;
MRACgam5=2000;
