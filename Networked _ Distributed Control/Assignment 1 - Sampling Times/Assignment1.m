clear
close all
clc
type = 0;
%% CT Pole-placement
A = [72 9;0 2.7];
B = [0;1];
p = [-2,-2];
K = acker(A,B,p);
cl = A-B*K;
eig(cl);
%% 1.1 Exact Discretization, no delay
syms f1(h) f2(h)
[S,J] = jordan(A);
expAh = [exp(72*h) (exp(72*h)-exp(2.7*h))/7.7;0 exp(2.7*h)];
Adt = expAh - A\(expAh - eye(2))*B*K;
E = eig(Adt);
f1(h) = E(1);
f2(h) = E(2);
%% 1.2 Constant small delay (t<h)
step = 250;
stab = zeros(step,step);
for h=0:0.05/step:0.05
    for t=0:0.05/step:0.05
        hi = uint16(h/0.05*step+1);
        ti = uint16(t/0.05*step+1);
        if ti > hi
            stab(ti,hi) = 1;
        else
            lambda = eigenht(h,t,A,S,B,K);
            if any(abs(lambda)>1)
                stab(ti,hi) = -1;
            end
            if type == 1 
                clc
                fprintf('h:%.4f, t:%.4f \n%.3f \n%.3f \n%.3f \n\nStab: %.0f \n',h,t,lambda(1),lambda(2),lambda(3),stab(ti,hi))
                pause(1)
            end
        end
    end
    clc
    fprintf('%.0f',h*2000)
end
%% 1.3 Constant big delay (h<t<2h)
stab2 = zeros(step,step);
stab3 = zeros(step,step);
for h=0:0.05/step:0.05
    for t=0:0.05/step:2*0.05
        td = t - h;
        hi = uint16(h/0.05*step+1);
        ti = uint16(t/0.05*step+1);
        if ti > 2*hi
            stab2(ti,hi) = 1;
            stab3(ti,hi) = 1;
        elseif ti < hi
            stab2(ti,hi) = 1;
            stab3(ti,hi) = stab(ti,hi);
        else
            lambda = eigenh2t(h,td,A,S,B,K);
            if any(abs(lambda)>1)
                stab2(ti,hi) = -1;
                stab3(ti,hi) = -1;
            end
            if type == 2
                clc
                fprintf('h:%.4f, t:%.4f \n%.3f \n%.3f \n%.3f \n%.3f \n\nStab: %.0f \n',h,t,lambda(1),lambda(2),lambda(3),lambda(4),stab2(ti,hi))
                pause(1)
            end
        end
    end
    clc
    fprintf('%.0f',h*2000)
end
clc
%% 1.4a 
% From the second plot (small delays) it is possible to read this interval.
% Obviously it should be bigger than 5 ms. Following the line t = 0.75h
% shows the latest GAS point at  h = 10.2 ms (t = 7.6 ms). 
%% 1.4b
% From the last plot it is obvious that the system gets more robust with
% lower sampling times. Therefore 5ms would make the system the most
% robust against delays. However, the sensitivity gets rather low below
% 8.8ms. Therefore this choice could be argued for as well. 
%% 1.5
% It is possible to chose significant faster poles. This will make the
% system more robust for delays. However, it will also cause less
% robustness against disturbance. It will also result in significantly
% higher control actions. 
p2 = [-0.02 -0.02];
K2 = acker(A,B,p2);
stabk_t = zeros(step+1,step+1);
for h=0:0.05/step:0.05
    for t=0:0.05/step:0.05
        hi = uint16(h/0.05*step+1);
        ti = uint16(t/0.05*step+1);
        if ti > hi
            stabk_t(ti,hi) = 0;
        else
            lambda = eigenht(h,t,A,S,B,K2);
            if ~any(abs(lambda)>1)
                stabk_t(ti,hi) = 2;
            end
            if type == 1 
                clc
                fprintf('h:%.4f, t:%.4f \n%.3f \n%.3f \n%.3f \n\nStab: %.0f \n',h,t,lambda(1),lambda(2),lambda(3),stab(ti,hi))
                pause(1)
            end
        end
    end
    clc
    fprintf('%.0f',h*2000)
end
stabk = stab - stabk_t;
%% 1.6 No delay, varying sampling interval
interval = 0.05;
steps = interval / 0.005;
h = linspace(0.005,interval,steps);
stab1_6 = zeros(length(h),1);
Adt = zeros(2,2,steps);
for n=1:steps
    expAh = [exp(72*h(n)) (exp(72*h(n))-exp(2.7*h(n)))/7.7;0 exp(2.7*h(n))];
    Adt(1:2,1:2,n) = expAh - A\(expAh - eye(2))*B*K;
    stab1_6(n) = evalstab(h(1:n),Adt);
    clc
    fprintf('%.0f',100/steps*n)
    if stab1_6(n) == 0
        clc
        break
    end
end
%% Plotjes
close all
t1 = 0;
t2 = 0.05;
figure
fplot(f1,[t1,t2]);
hold on
fplot(f2,[t1,t2]);
y2 = @(h) -sqrt(1-h^2);
fplot(y2,[t1,t2])
xlabel('Sampling time h [s]')
ylabel('Closed Loop Eigenvalues')
legend('Eigenvalue 1','Eigenvalue 2','Stability Boundary')
title('Closed-Loop DT Stability Analysis, no delay')

figure
li = linspace(0,0.05,step);
imagesc(li,li,stab)
set(gca,'YDir','normal')
xlabel('Sampling time h')
ylabel('Total Delay \tau')
title('Small Delay') 

figure
li = linspace(0,0.05,step);
li2 = linspace(0,0.1,step);
imagesc(li,li2,stab2)
set(gca,'YDir','normal')
title('Big Delay')
xlabel('Sampling time h')
ylabel('Total Delay \tau')

figure
li = linspace(0,0.05,step);
li2 = linspace(0,0.1,step);
imagesc(li,li2,stab3)
set(gca,'YDir','normal')
title('Big Delay')
xlabel('Sampling time h')
ylabel('Total Delay \tau')

figure
li = linspace(0,0.05,step);
li2 = linspace(0,0.05,step);
imagesc(li,li2,stabk)
set(gca,'YDir','normal')
title('Fast Poles improvement')
xlabel('Sampling time h')
ylabel('Total Delay \tau')

figure
plot(h,stab1_6);
title('Lyapunov Quadratic Stability')
xlabel('Sampling time h')
ylabel('Stability')