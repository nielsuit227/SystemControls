%%% Programme for the Quadratic optimization for SC40055 by Niels
%%% Uitterdijk, 28 Sept 2017. 
%%% Prediction of university students for coming years. X1, X2, X3
%%% represents BSc, MSc, Ph.D. New (k+1) BSc students is in/de-creased by u1(k)
close all
clear
clc
%% Student number
D1 = 8;
D2 = 9;
D3 = 2;
%% Known parameters
a3 = 0.05 + D1/200;
b3 = 0.05 - D2/200;
c3 = 0.1 + D3/200;
%% Dataset
u1(1:9) = [1273 1142 1106 1110 1125 1138 1156 1200 1125];
u2(1:9) = [100 101 102 100 94 91 101 101 100];
u3(1:9) = [42 41 39 38 38 41 41 40 42];
X1(1:10) = [2800 2971 2940 2885 2855 2852 2863 2887 2945 2905];
X2(1:10) = [900 776 729 704 686 668 656 661 665 671];
X3(1:10) = [220 257 275 283 287 289 292 294 294 297];
y1(1:10) = [840 891 882 866 857 856 859 866 884 872];
y2(1:10) = [432 372 350 338 329 321 315 317 319 322];
y3(1:10) = [24 28 30 31 32 32 32 32 32 33];
X(1:10,:) = [X1' X2' X3'];
u(:,1:9) = [u1' u2' u3']';
Y_data(1:10,:) = [y1' y2' y3'];
%% QP constraint
Aeq(1,1:3) = [0 0 1];
Aeq(2,1:3) = [0 0 0];
Aeq(3,1:3) = [1 0 0];
beq = 0;
%% QP for three independent rows
for n=1:3
    Y = X(2:10,n) - u(n,1:9)';
    phi = [X(1:9,:)];
    H = 2*phi'*phi;
    c = (-2*phi'*Y)';
    temp_result = quadprog(H,c,[],[],Aeq(n,1:3),beq);
    a1_qp(n) = temp_result(1);
    a2_qp(n) = temp_result(2);
    a3_qp(n) = temp_result(3);
end
%% Creating matrix A and matrix B
A = [a1_qp' a2_qp' a3_qp']
%% Solving all constants (a3,b3,c3 are known)
a1 = A(2,1);
b1 = A(3,2);
b4 = A(1,2);
c4 = A(3,2);
a2 = 1 - a1 - a3 - A(1,1);
b2 = 1 - b1 - b3 - b4 - A(2,2);
c2 = 1 - c3 - c4 - A(3,3);
%% Creating C
C = [a1+a2, 0,0;0,b1+b2+b4,0;0,0,c2+c4];
%% Checken data
for n=1:9
    X_pred(n+1,:) = A*X(n,:)' + u(:,n);
    Y_pred(n,:) = C*X(n,:)';
end
%% Plot data X1
figure
subplot(2,3,1)
plot(X(:,1))
title('X1 data')
hold on
plot(X_pred(:,1))
legend('Data','Model')
%% plot data X2
subplot(2,3,2)
plot(X(:,2))
title('X2 data')
hold on
plot(X_pred(:,2))
legend('Data','Model')
%% plot data X3
subplot(2,3,3)
plot(X(:,3))
title('X3 data')
hold on
plot(X_pred(:,3))
legend('Data','Model')
%% plot data Y1
subplot(2,3,4)
plot(Y_data(:,1))
title('Y1 data')
hold on
plot(Y_pred(:,1))
legend('Data','Model')
%% plot data Y2
subplot(2,3,5)
plot(Y_data(:,2))
title('Y2 data')
hold on
plot(Y_pred(:,2))
legend('Data','Model')
%% plot data Y3
subplot(2,3,6)
plot(Y_data(:,3))
title('Y1 data')
hold on
plot(Y_pred(:,3))
legend('Data','Model')




