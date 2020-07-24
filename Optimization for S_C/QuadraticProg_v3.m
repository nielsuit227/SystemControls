%%% Programme for the Quadratic optimization for SC40055 by Niels
%%% Uitterdijk, 28 Sept 2017. 
%%% Prediction of university students for coming years. X1, X2, X3
%%% represents BSc, MSc, Ph.D. 
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
Y0 = Y_data(1,:);
%% QP for three independent rows
for n=1:3
    Y = X(2:10,n) - u(n,1:9)';
    phi = [Y_data(1:9,:)];
    H = 2*phi'*phi;
    c = (-2*phi'*Y)';
    temp_result = quadprog(H,c,[],[],Aeq(n,1:3),beq,[],[],Y0); 
    a1_qp(n) = temp_result(1);
    a2_qp(n) = temp_result(2);
    a3_qp(n) = temp_result(3);
end
%% Creating matrix A and matrix B
A_qp = [a1_qp' a2_qp' a3_qp'];
%% Solving all constants (a3,b3,c3 are known)
syms a1 a2 b1 b2 b4 c2 c4
[a1 a2] = solve(a1_qp(1) == (1-a1-a2-a3)/(a1+a2), a1_qp(2) == a1 / (a1+a2),a1,a2);
a1 = double(a1);a2 = double(a2);
[b1 b2 b4] = solve(a2_qp(1) == b4 / (b1+b2+b4), a2_qp(2) == (1-b1-b2-b3-b4)/(b1+b2+b4), a2_qp(3) == b1/(b1+b2+b4),b1,b2,b4);
b1 = double(b1); b2 = double(b2); b4 = double(b4);
[c2 c4] = solve(a3_qp(2) == c4 / (c2+c4), a3_qp(3) == (1-c4-c2-c3)/(c2+c4),c2,c4);
c2 = double(c2); c4 = double(c4);
%% Creating C
A = [1-a1-a2-a3,b4,0;a1,1-b1-b2-b3-b4,c4;0,b1,1-c2-c3-c4];
C = [a1+a2, 0, 0; 
        0, b1+b2+b4, 0; 
            0, 0, c2+c4];
save('A_&_C_Matrix.mat','A','C')
%% Modelled data
X_pred(1,:) = X(1,:);
for n=1:9
    X_pred(n+1,:) = A*X(n,:)' + u(:,n);
    Y_pred(n,:) = C*X(n,:)';
end
Y_pred(10,:) = C*X(10,:)';
for n=1:3
e(:,n) = abs((X(:,n)-X_pred(:,n))./X_pred(:,n))*100;
end
for n=1:3
    e(:,n+3) = abs((Y_data(:,n)-Y_pred(:,n))./Y_pred(:,n))*100;
end
for n=1:6
    e_avg(n) = sum(e(:,n)) / length(e(:,n));
end
%% Plot data X1
t = linspace(2008,2017,10);
figure('units','normalized','outerposition',[0 0 1 1],'name','Predictive model and the original data of the amount of students')
subplot1 = subplot(2,3,1);
plot(t,X(:,1),'linewidth',2)
set(subplot1,'FontSize',14);
title('BSc Students')
hold on
plot(t,X_pred(:,1),'linewidth',2)
legend('Data','Model')
%% plot data X2
subplot2 = subplot(2,3,2);
plot(t,X(:,2),'linewidth',2)
title('MSc Students')
hold on
plot(t,X_pred(:,2),'linewidth',2)
legend('Data','Model')
set(subplot2,'FontSize',14);
%% plot data X3
subplot3 = subplot(2,3,3);
plot(t,X(:,3),'linewidth',2)
title('Ph.D. Students')
hold on
plot(t,X_pred(:,3),'linewidth',2)
legend('Data','Model')
set(subplot3,'FontSize',14);
%% plot data Y1
subplot4 = subplot(2,3,4);
plot(t,Y_data(:,1),'linewidth',2)
title('BSc Graduations')
hold on
plot(t,Y_pred(:,1),'linewidth',2)
legend('Data','Model')
set(subplot4,'FontSize',14);
%% plot data Y2
subplot5 = subplot(2,3,5);
plot(t,Y_data(:,2),'linewidth',2)
title('MSc Graduations')
hold on
plot(t,Y_pred(:,2),'linewidth',2)
legend('Data','Model')
set(subplot5,'FontSize',14);
%% plot data Y3
subplot6 = subplot(2,3,6);
plot(t,Y_data(:,3),'linewidth',2)
title('Ph.D. Graduations')
hold on
plot(t,Y_pred(:,3),'linewidth',2)
legend('Data','Model')
set(subplot6,'FontSize',14);