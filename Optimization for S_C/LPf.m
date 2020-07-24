function [X,Profit] = LPf(A,b,C,c)
%% Simulation
steps = 100;
%% Size of A
Ac = length(A(1,:));
Ar = length(A(:,1));
%% Set up B, N and C
B = A(:,1:Ar);
N = A(:,Ar+1:Ac);
Cb = C(1:Ar);
Cn = C(Ar+1:Ac);
x = [1;2;3;4];
%% Loop
for n=1:steps
    
    % Calculate Xb and Xn for basic solution
    Xb = B^-1*b;
    Xn = 0;
    
    % Calculate P and its minimum location i
    P = (Cn'-Cb'*B^-1*N)'; 
    [~,i] = min(P);
    
    % Calculate Y, XY and its minimum location j
    XY = B^-1*N(:,i);
    if XY(1) >= 10^(-12) && XY(2) >= 10^(-12)
        [~,j] = min(XY);
    elseif XY(1) >= 10^(-12) && XY(2) <= 10^(-12)
        j=1;
    elseif XY(2) >= 10^(-12) && XY(1) <= 10^(-12)
        j=2;
    else
        fprintf('No optimal solution found.')
        break
    end
    % Saving vectors temporarily
    temp_B = B;
    temp_N = N;
    temp_Cb = Cb;
    temp_Cn = Cn;
    temp_x = x;
    % Exchanging columns
    B(:,j) = temp_N(:,i);
    N(:,i) = temp_B(:,j);
    Cb(j) = temp_Cn(i);
    Cn(i) = temp_Cb(j);
    x(i) = temp_x(j);
    x(j) = temp_x(i);      
    if P >= 10^(-12)
        break
    end
end
X(x(1)) = floor(Xb(1));
X(x(2)) = floor(Xb(2));
X(x(3)) = floor(Xn(1));
X(x(4)) = floor(Xn(1));
X = X(1:2)';
Profit = -c(1)*X(1) + -c(2)*X(2);
end
