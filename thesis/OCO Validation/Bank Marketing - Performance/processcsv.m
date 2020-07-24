clear
clc
close all
str = 'bankaddfull.mat';
load(str)
Xt = X;
[n,m] = size(Xt);
X = zeros(n,48);                        
Y = zeros(n,1);
%% Load variables
Y(Xt(:,m) == 'no') = -1;                % Labels
Y(Xt(:,m) == 'yes') = 1;
X(:,1) = Xt(:,1);                       % Age directly
X2 = categorical(Xt(:,2));              % Job dummyvar
i = size(dummyvar(X2)); e2 = i(2)+1;
X(:,2:e2) = dummyvar(X2);
X3 = categorical(Xt(:,3));              % Maried dummyvar
i = size(dummyvar(X3)); e3 = e2+i(2);
X(:,e2+1:e3) = dummyvar(X3);
X4 = grp2idx(categorical(Xt(:,4)));     % Education index
X4(X4==5) = -1; X4(X4==8) = 0; X4(X4==6) = 5; X4(X4==7) = 6;
X(:,e3+1) = X4;
X5 = categorical(Xt(:,5));              % Default
X(X5 == 'yes',19) = 1;
X(X5 == 'no',19) = -1;
X6 = categorical(Xt(:,6));              % Housing
X(X6 == 'yes',20) = 1;
X(X6 == 'no',20) = -1;
X7 = categorical(Xt(:,7));              % Loan
X(X7 == 'yes',21) = 1;
X(X7 == 'no',21) = -1;
X8 = categorical(Xt(:,8));              % Contact
X(:,22:23) = dummyvar(X8);
X9 = categorical(Xt(:,9));              % Month
X(:,24:33) = dummyvar(X9);
X10 = categorical(Xt(:,10));            % Day of week
X(:,34:38) = dummyvar(X10);
X(:,39) = categorical(Xt(:,11));        % Duration call
X(:,40) = categorical(Xt(:,12));        % Campaign
X(:,41) = categorical(Xt(:,13));        % Paid days
X(:,42) = categorical(Xt(:,14));        % Previous
X15 = grp2idx(categorical(Xt(:,15)));   % Paid Outcome
X(X15==1,43) = -1; X(X15==2,43) = 0; X(X15==3,43) = 1;
X(:,44:48) = categorical(Xt(:,16:20));  % emp var rate, cons price idx, cons conf idx, euribor3m
save(str,'X','Y')