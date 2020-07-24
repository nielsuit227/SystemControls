clear
close all
clc
%% Given matrices
A = [0.6 0.9; 0 0.7];
B = [0; 1];
K = [6 4.3];
h = 0.1;
%% 2.1 Max dropouts
% The system is only stable for so many consecutive dropouts. By a long
% period of dropouts, the system matrices change. For different amount of
% dropouts the system matrices are calculated, and stability analysis is
% done by the eigenvalues. 
for i = 1:100
    lambda = eigenCL(i, A, B, K, h);
    if abs(lambda(1))>= 1 || abs(lambda(2))>=1
%         fprint('%.3f', lambda)
        disp(lambda)
        disp('Maximum subsequent number of dropouts is')
        disp(i)
        break
    end
end
%% 2.3 Bernoulli probability MSS
% Now the dropout has stochastic properties, on which we can base the
% system matrices. The switched behaviour stability as assessed by Mean
% Square Stable (MSS), a double lyapunov quadratic function. 
A1   = [exp(0.6*h) 9*(exp(0.7*h)-exp(0.6*h)); 0 exp(0.7*h)];
Aint    = A\(A1 - eye(2))*B*K;
A0 = A1 - Aint;
p = defP(A1, A0);
disp('Maximum Probability of dropouts is:')
disp(p)
%% 2.4 Time traces
% In order to check the result of 2.1 and 2.3, the system is simulated for
% a different amount of maximum dropouts. 
X(:,1) = [randi(10)-5;randi(10)-5];
c = 0;
p = 0.75;
figure
for p=0.5:0.1:0.8
for n = 2:250
    i = rand;
    if i <= p && c <= 5        %% dropout
        X(:,n) = X(:,n-1) + h*A*X(:,n-1);
        c = c +1;
    else                            %% no dropout
        X(:,n) = X(:,n-1) + h*(A-B*K)*X(:,n-1);
        c = 0;
    end
end
hold on
plot(X(1,:))
end
legend('P = 0.5','P=0.6','P=0.7','P=0.8')
p = 0.7808;
figure
for m=1:10
    X(:,1) = [randi(10)-5;randi(10)-5];
for n = 2:250
    i = rand;
    if i <= p && c <= 5        %% dropout
        X(:,n) = X(:,n-1) + h*A*X(:,n-1);
        c = c +1;
    else                            %% no dropout
        X(:,n) = X(:,n-1) + h*(A-B*K)*X(:,n-1);
        c = 0;
    end
end
hold on
plot(X(1,:))
end
title('Time traces for p=0.75')
%% 2.5 Gilbert-Elliot 
Z = defPGE(A1,A0);
%%
figure
li = linspace(0,1,10);
imagesc(li,li,Z)
set(gca,'YDir','normal')
xlabel('P_{00} (Chance to stay without dropout)')
ylabel('P_{11} (Chance to stay with dropout)')
title('Stability using Gilbert-Elliot model') 



