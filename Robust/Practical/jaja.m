systemnames ='G Wp Wu'; % Define's the given system
inputvar ='[w(2); u(2)]'; % Input of the Generalized plant
input_to_G= '[u]';
input_to_Wu= '[u]';
input_to_Wp= '[w+G]';
outputvar= '[Wp; Wu; -G-w]'; % Output of the Generalized plant
sysoutname= 'P';
sysic;
[K_h,~,GAM H,~] = hinfsyn(P,2,2);


systemnames ='G Wp Wu Wi Wo'; % Defin's the given system with Uncertainity
inputvar ='[del i(2);del o(2);w(2);u(2)]'; % Input of Generalized plant
input_to_G= '[u+deli]';
input_to_Wu= '[u]';
input_to_Wp= '[w+G+delo]';
input_to_Wi= '[u]';
input_to_Wo= '[G]';
outputvar= '[Wi; Wo; Wp; Wu; -G-w-delo]'; % Output of Generalized plant
sysoutname='PDel';
cleanupsysic= 'yes';
sysic;
N=lft(PDel,K_h);
muNP_SV = norm(N(5:8,5:6),inf);
muNP = mussv(N(5:8,5:6),[2 4]);
muNP_SSV = norm(muNP(:,1),inf)
% Robust Stability
muRS = mussv(N(1:4,1:4),ones(4,2));
muRS_max = norm(muRS(:,1),inf)
% Robust Performance
block = ones(5,2);
block(5,1) = 2; block(5,2) = 4;
muRP = mussv(N,block);                      %% Calculating SSV for full N
muRP_max = norm(muRP(:,1),inf)
%% DK-iterations
omega=logspace(-3,3,61);
opt=dkitopt('FrequencyVector', omega,'DisplayWhileAutoIter','on');
Punc = lft(D,P_h);
[K,clp,bnd,dkinfo]=dksyn(Punc,2,2,opt);