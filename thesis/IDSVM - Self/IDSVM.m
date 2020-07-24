function [alpha,b,XC,YC,g,inds,inde] = IDSVM(K,C,xc,yc,iter)
% Incremental & Decremental Support Vector Machine
%
% Inputs:  K        Kernel function
%          C        Regularization weight
%          xc       Candidate features
%          yc       Candidate label
%          iter     Iteration count (necessary for initialization)
%
% Outputs: alpha    New Lagrange multipliers
%          b        New bias
%          X        Corresponding data features
%          Y        Corresponding data labels
%          g        Corresponding KKT function values
%
% Required global parameters:
% eps - Threshold on KT condition for discarding datapoint 
% mem - Number of datapoints allowed in memory



%%% Notes 5/2/2018
%%% Although the algorithm works perfectly, it could still be improved by
%%% the way it handles the kernel matrix. Right now it calculates a new
%%% EV/SV for all EV and SV's while it only uses the SV's to update the
%%% Lagrange multipliers. Anyhow, not usefull as I understand the method
%%% and the original file by Cauwenbergh and Poggio is faster. 
t = true; f = false;
%% Declare variables
global eps mem tol eta
persistent A B X Y Q S R E
%% Initialize persistents 
if iter == 1
    X = xc;
    Y = yc;
    A = 0;
    B = yc;
    Q = K(X,X);
    E = f;
    R = f;
    S = t;
    alpha = A; b = B; XC = X; YC = Y; g = 0; inds = S; inde = E;
    return
else   
%% Check inputs
    if size(xc,1) ~= size(X,1)
        error('Inconsistent input (iteration %.0f)',iter);
    end
    if yc ~= 1 && yc ~= -1
        error('Wrong label (iteration %.0f)',iter);
    end
end
%% Calculate new Gram matrix
% Calculate new kernel values
Q_t = zeros(size(X,2),1);
for i = 1:size(X,2)
    Q_t(i) = Y(i)*yc*K(X(:,i),xc);    
end
% Add them to old Gram matrix
Qc = [Q Q_t;Q_t' 1];
%% Increment Lagrange multiplier
% Check whether it's in R or S&E. 
%gc = Q_t(S)'*A(S) + yc*B - 1; % ac is left out as is zero.
gc = Qc(end,:)*[A;0] + yc*B - 1;
if gc >= 0
    X = [X xc];
    Y = [Y yc];
    A = [A;0];
    S = logical([S;0]);
    R = logical([R;1]);
    E = logical([E;0]);
    Q = Qc;
    alpha = A;
    XC = X;
    YC = Y;
    g = Q*A + Y'*B -1;
    b = B;
    inde = E;
    inds = S;
else
%% Increment candidate
ac = 0;
OR = 1;     % OverRide
while(gc <= -tol && ac <= C-tol || OR || ac > C+tol || ac < -tol)
    OR = 0;
    %% Increment on ac by setting gc to zero. 
    dac = eta*min(-gc,C-ac);                            % Potential increment ac
    Rq = [0 Y(S);Y(S)' Q(S,S)];
    beta = [yc;Q_t(S)];
    [A,B,ac] = increment(dac,S,Rq,beta,C,A,B,ac);
    % Check Support Vectors
    S = (A > tol & A < C-tol);     % New Support Vectors   
    E = A > C-tol;                  % New Error Vectors
    R = A <= tol;                   % New Rest Vectors
    % Update KKT function
    g = Qc*[A;ac] + [Y';yc]*B - 1;
    %% Update incorrect E multipliers
    % If any value of g in set E is higher than 0 it should become a SV.
    % This is looped over all values for which this is true. 
    for i = find(g(E)>=tol)'
        A = [A;ac];        % Include ac in set S
        Y = [Y yc];     
        S = (A > tol & A <= C-tol);
        % Find original index of i-th change.
        t1 = find(E == 1,i); t1 = t1(end);  
        % We keep updating until the KT conditions are fulfilled.
        while (g(t1) >= tol && A(t1)>0)||(g(t1) <= -tol && A(t1) < C)
            Si = S; Si(t1) = f;
            dAi = max(min(-g(t1),C-A(t1)),-A(t1));      
            Rq = [0 Y(Si); Y(Si)' Qc(Si,Si)];
            beta = [Y(t1);Qc(Si,t1)];
            [A,B,Asi] = increment(dAi,Si,Rq,beta,C,A,B,A(t1));
            A(t1) = Asi;
            % Calculate new KT value and if possible, put t1 in S.
            g = Qc*A + Y'*B - 1;   
            S = (A > tol & A <= C-tol); 
        end  
        ac = A(end);            % Split ac again
        A = A(1:end-1);
        S = S(1:end-1);
        Y = Y(1:end-1);
        OR = 1;
    end
    %% Update wrong R multipliers
    % Whenever a KT value is smaller than zero for a point in the Rest set,
    % it can be increased. This loops through all those values and forces
    % them to fulfill the KT condition. 
    for i = find(g(R)<=-tol)'
        A = [A;ac];        % Include candidate in set
        Y = [Y yc];
        S = (A > tol & A <= C-tol);
        % Find suboptimal multiplier
        t1 = find(R == 1,i); t1 = t1(end);
        while (g(t1) <= -tol && A(t1) ~= C) || (g(t1) >= tol && A(t1) ~= 0)
            Si = S; Si(t1) = f;   % Set Si(t1) to false as this is the one we're continuously changing here
            dAi = max(min(-g(t1),C-A(t1)),-A(t1));
            Rq = [0 Y(Si); Y(Si)' Qc(Si,Si)];
            beta = [Y(t1);Qc(Si,t1)];
            [A,B,Asi] = increment(dAi,Si,Rq,beta,C,A,B,A(t1));
            A(t1) = Asi;
            g = Qc*A + Y'*B - 1;
            S = (A > tol & A <= C-tol);  
        end
        ac = A(end);            % Split ac again
        A = A(1:end-1);
        S = S(1:end-1);
        Y = Y(1:end-1);
        OR = 1;
    end     
    g = Qc*[A;ac] + [Y';yc]*B - 1;
    gc = g(end);
end
%% Include in data
X = [X xc];
Y = [Y yc];
A = [A;ac];
Q = Qc;
g = Q*A + Y'*B -1;
%% Update indices
S = (A > tol & A <= C-tol);     % New Support Vectors   
E = A > C-tol;                  % New Error Vectors
R = A <= tol;                   % New Rest Vectors
end
%% Decrement
if size(X,2) > mem
    % We start forgetting the properly classified points, they don't
    % contribute to the hyperplane (right now).
    if any(R==1)
        % Instead use max g
        [~,i] = max(g(R)); dt = find(R==1); i = dt(i);
        X(:,i) = [];Y(i) = [];A(i) = [];Q(i,:) = [];Q(:,i) = [];g(i) = [];S(i) = [];R(i) = [];E(i) = [];
    elseif any(S==1)
%         Chose the lowest multiplier
        delete = 0;
        [~,t] = min(A(S)); t=find(S==1,t); c = t(end);  % c is candidate index
        S(c) = f;                   % Exclude c from S
        %%% Have to store all variables somehow, cause if gc becomes
        %%% negative I have to undo the changes... blugh
        temp.A = A; temp.Y = Y; temp.X = X;
        while ~delete || OR     
            OR = 0;
            %% Update
            S(c) = f;
            dac = max(-g(c)-1,-A(c));     % Maximum decrement for c
            Rq = [0 Y(S);Y(S)' Q(S,S)];
            beta = [Y(c);Q(S,c)]; 
            [A,B,Ac] = increment(dac,S,Rq,beta,C,A,B,A(c));
            A(c) = Ac;
            g = Q*A + Y'*B - 1;
            %% Update indices
            S = (A > tol & A <= C-tol);     % New Support Vectors   
            E = A > C-tol;                  % New Error Vectors
            R = A <= tol;                   % New Rest Vectors
            %% Check for incorrect E (g(E) >= 0)
            E(c) = f; R(c) = f;
            for i = find(g(E) >= tol)'
                t1 = find(E == 1,i); t1 = t1(end);  
                while (g(t1) <= -tol && A(t1) ~= C) || (g(t1) >= tol && A(t1) ~= 0)
                    Si = S; Si(t1) = f;  % Set Si(t1) to false as this is the one we're continuously changing here
                    dAi = max(min(-g(t1),C-A(t1)),-A(t1));
                    Rq = [0 Y(Si); Y(Si)' Q(Si,Si)];
                    beta = [Y(t1);Q(Si,t1)];
                    [A,B,Asi] = increment(dAi,Si,Rq,beta,C,A,B,A(t1));
                    A(t1) = Asi;
                    g = Q*A + Y'*B - 1;
                    S = (A > tol & A <= C-tol);  
                end
                OR = 1;
            end
            %% Check for incorrect R (g(R) <= 0)
            for i = find(g(R) <= -tol)'
                t1 = find(R == 1,i); t1 = t1(end);
                while (g(t1) <= -tol && A(t1) ~= C) || (g(t1) >= tol && A(t1) ~= 0)
                    Si = S; Si(t1) = f;   % Set Si(t1) to false as this is the one we're continuously changing here
                    dAi = max(min(-g(t1),C-A(t1)),-A(t1));
                    Rq = [0 Y(Si); Y(Si)' Q(Si,Si)];
                    beta = [Y(t1);Q(Si,t1)];
                    [A,B,Asi] = increment(dAi,Si,Rq,beta,C,A,B,A(t1));
                    A(t1) = Asi;
                    g = Q*A + Y'*B - 1;
                    S = (A > tol & A <= C-tol);  
                end
                OR = 1;
            end
            % Update g
            g = Q*A + Y'*B - 1;
            %% Terminate criteria (either gc<0 or ac = 0)
            if A(c) == 0
                X(:,c) = []; Y(c) = []; A(c) = []; Q(c,:) = []; Q(:,c) = []; g(c) = [];S(c)=[];R(c)=[];E(c)=[];
                delete = 1;
                OR = 0;
            elseif g(c) <= tol-1
                A = temp.A; X = temp.X; Y = temp.Y;
                S = A>tol & A<= C-tol; S(c) = f;
                g = Q*A + Y*B - 1;
                [~,t] = min(A(S)); t=find(S==1,t); c = t(end);  % c is candidate index
                S(c) = f;
                OR = 0;
            end
        end
    
    end
end
% Functions
function [a,b,c] = increment(inc,s,rq,bet,c,a,b,ac)
%% Update values
dba = rq\bet*inc;
bc = a(s) - dba(2:end);
if any(bc > C) || any(bc < 0)
    u = (c-a(s))./(bc - a(s));
    u = min([u(u>0);1]);    
    l = (a(s)./(a(s)-bc));
    l = min([l(l>0);1]);
    scale = min(abs(u),min(abs(l),1));    
    dba = dba * scale;
    inc = inc * scale;    
end
c = ac + inc;
a(s) = a(s) - dba(2:end);
b = b - dba(1);
%% Check bounds
if any(A > C+tol) || any(A < -tol)
    error('Lagrange Multiplier # %.0f out of bounds (iteration %.0f) ',find(A > C+tol | A < -tol),iter)
end
end
%% Check KT conditions
if sum(S) == 0
    warning('Increase regulariation term')
end
if Y*A >= 10*tol || Y*A <= -10*tol 
    error('KT condition on bias not fulfilled (iteration %.0f)',iter)   
end
if any(g > tol*10 & A >= 0.1*C | g < -tol*10 & A <= 0.99*C)
    error('KT condition on alpha # %.0f not fulfilled (iteration %.0f)',find(g > tol & A >= 0.1*C | g < -tol & A <= 0.99*C),iter)
end
XC = X;
YC = Y;
alpha = A;
b = B;
fprintf('Iteration %.0f done, %.0f SV, %.0f EV\n',iter,sum(S),sum(E))
%% Ask to increase memory
if sum(S)+sum(E) == mem
    beep
    fprintf('Memory (%.0f) full. \n',mem)
    prompt = 'Increase memory by:\n';
    IP = input(prompt);
    mem = mem + IP;
end
inde = E;
inds = S;
end