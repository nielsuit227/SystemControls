%%% Script for the first assignment of Filtering and Identification by
%%% Niels Uitterdijk, December '17. 
close all
%% Load data
load('rocket.mat')
%% Model parameters
dt = 0.1;           % [s]
m = 100;            % [kg]
%% 1. State space description of simplified rocket dynamics
% Both the Continuous as the Discrete model give the same outcome. Although
% this is not very accuracte when compared to the measured data or the real
% data, it does coincide with the measured trajectory once. 
Ac = [0 1; 0 0];
Bc = [0 0 0; 1/m -1 -1/m];
Cc = [1 0];
Dc = 0;
%% Descretised model of simplified rocket dynamics
Ad = [1 dt; 0 1];
Bd = [dt^2/2/m, -dt^2/2, -dt^2/(2*m); dt/m, -dt, -dt/m];
Cd = [1 0];
Dd = 0;
%% Simulate the discrete model
Xd = zeros(2,length(u)); Yd = zeros(1,length(u));
for n=1:length(u)-1
    Xd(:,n+1) = Ad*Xd(:,n) + Bd*u(n,:)';
    Yd(n+1) = Cc*Xd(:,n+1);
end
%% Simulate the continuous model
T = linspace(0,(length(u)-1)*dt,length(u));
rocket_con = ss(Ac,Bc,Cc,Dc);
[Yc, Tc, Xc] = lsim(rocket_con,u',T,[]);
%% Plot outcome
figure
plot(T,Yc,T,Yd,T,ytrue)
legend('Continuous Model','Discrete Model','Data')
%% 2. Generate Asymptotic Observer 
% The discrete model was used to generate an Asymptotic Observer. The model
% has significantly increased in accuracy. Although the variance of the
% speed estimation is still quite high, the estimation seems unbiased. Also
% the altitutide estimation has increased significantly, with an accuracy 
% of 8m at an altitude of 3000m. 
if rank([Cd; Cd*Ad]) == 2
    fprintf('The system is Observable\n');
else
    fprintf('The system is NOT Observable\n');
end
p = [0.8 0.7];
Kao = place(Ad',Cd',p)';
%% Simulate the discrete Asymptotic Observer model
Xao = zeros(2,length(u)); Yao = zeros(1,length(u));
Uao = [u y];
for n=1:length(u)-1
    Xao(:,n+1) = [Ad - Kao*Cd]*Xao(:,n) + [Bd Kao]*Uao(n,:)';
    Yao(n+1) = Cd*Xao(:,n+1);
end
hold on
%% Validation of Asymptotic Observer
figure % Check altitude estimation
plot(T,Yao,T,ytrue)
legend('Asymptotic Observer','Data');title('Altitude Estimation')
figure % Check velocity estimation
plot(T,Xao(2,:),T,ydottrue)
legend('Asymptotic Observer','Data');title('Speed Estimation')
%% 3. Kalman filter
% The Kalman filter results in a lot smoother speed estimation. The
% variance is now significantly lower while keeping the unbiasedness.
% However, the variance of the estimate of the altitude has slightly
% decreased. The variance matrix of the model is quite hard to estimate
% although the consequences of in/de-creasing it is obvious. I would
% conclude that the Kalman filter yields a better result than the
% asymptotic observer as the speed estimation is much more reliable now
% while the altitude estimation only slightly decreases in variance but
% still remains a very decent estimate. 
R = 1e3;                            % Variance matrix W (Model Accuracy)
Q = 0.1*eye(2);                     % Variance matrix V (Measurement Accuracy)
S = zeros(2,1);
if rank([Q^(1/2) Ad*Q^(1/2)]) == 2
    fprintf('The system is Reachable\n')
else
    fprintf('The system is NOT Reachable\n')
end
[P,L,Kkf] = dare(Ad',Cd',Q,R);
%% Simulate the discrete Kalman filter model
Xkf = zeros(2,length(u)); Ykf = zeros(1,length(u));
for n=1:length(u)-1
    Xkf(:,n+1) = (Ad - Kkf'*Cd)*Xkf(:,n) + Bd*u(n,:)' + Kkf'*y(n) ;
    Ykf(n+1) = Cd*Xkf(:,n+1); 
end
figure % Plot Kalman Filter Altitude Estimation
plot(T,y,T,Ykf)
legend('Data','Kalman Filter');title('Altitude Estimation')
figure % Plot Kalman Filter Speed Estimation
plot(T,ydottrue,T,Xkf(2,:))
legend('Data','Kalman Filter');title('Speed Estimation')
%% 4. Other possible methods
% One example that might work is the Moving Horizon Estimation. This should
% work as well but needs more iterations to converge. There are plenty of
% other options as well. For example as named in the book a recursive
% Kalman filter would probably also improve the estimates given here. 
%% 5. Design new Drag Model
% The rockets altitude estimation remains good. The speed estimation is 
% initially quite off and stays more noisy during the entire simulation and
% therefor has become slightly worse. The drag force is also quite noisy
% but does follow the actual drag force quite nicely. It is obvious that
% the variance of the estimation has to be quite high to keep a good
% estimation for the transient behaviour of the non-linear drag force. 
size = 3;
Adm = [Ad Bd(1:2,3); 0 0 1];
Bdm = [Bd(1:2,1:2); 0 0];
Cdm = [1 0 0];
Xdm = zeros(size,length(u)); Ydm = zeros(1,length(u));
Udm = [u(:,1:2)];
%% Design Kalman Filter for augmented state space model
Rdm = R;
Qw = 0.1*eye(size-1);
Qu = 50*eye(1);
Qdm = [Qw zeros(2,1);zeros(1,2) Qu];
[P,L,Kdm] = dare(Adm',Cdm',Qdm,Rdm);
%% Check requirement for no measurabl input sequence
if rank([Cdm; Cdm*Adm; Cdm*Adm*Adm]) == size
    fprintf('The new drag model is Observable\n');
else
    fprintf('The new drag model is NOT Observable\n');
end
if rank([Qdm^(1/2) Adm*Qdm^(1/2) Adm*Adm*Qdm^(1/2)] ) == size
    fprintf('The new drag model is Reachable\n')
else
    fprintf('The new drag model is NOT Reachable\n')
end
%% Simulate the discrete Kalman filter model
for n=1:length(u)-1
    Xdm(:,n+1) = (Adm - Kdm'*Cdm)*Xdm(:,n) + Bdm*Udm(n,:)' + Kdm'*y(n);
    Ydm(n+1) = Cdm*Xdm(:,n+1);
end
figure
plot(T,y,T,Ydm)
legend('Data','Kalman Filter');title('Altitude Estimation')
figure 
plot(T,ydottrue,T,Xdm(2,:))
legend('Data','Kalman Filter');title('Speed Estimation')
figure
plot(T,Xdm(3,:),T,dtrue)
legend('Estimated Drag Force','Real Drag Force')
title('Drag Model Estimation')
%% 6. Error comparison
% If one is interested in the drag force it is obvious that the Kalman
% filter with input estimation is the best. When solely interested in the 
% altitude estimation I would use the Asymptotic Observer. The Kalman
% filter does allow to shift the estimations between noisy and unbiasedness
% which can be very powerful. But only when the unknown input is also
% simulated the results start to significantly improve. 
N = length(ytrue);
E_ao(1) = sqrt(1/N*sum(ytrue - Yao')^2);
E_ao(2) = sqrt(1/N*sum(ydottrue - Xao(2,:)')^2);
E_ao(3) = sqrt(1/N*sum(dtrue - u(:,3))^2);
E_kf(1) = sqrt(1/N*sum(ytrue - Ykf')^2);
E_kf(2) = sqrt(1/N*sum(ydottrue - Xkf(2,:)')^2);
E_kf(3) = sqrt(1/N*sum(dtrue - u(:,3))^2);
E_dm(1) = sqrt(1/N*sum(ytrue - Ydm')^2);
E_dm(2) = sqrt(1/N*sum(ydottrue - Xdm(2,:)')^2);
E_dm(3) = sqrt(1/N*sum(dtrue - Xdm(3,:)')^2);
fprintf('Estimator, RMSE Altitude,  RMSE Speed, RMSE Drag\n')
fprintf('Asymptotic,        %.3f        %.3f        %.3f\n',E_ao(1),E_ao(2),E_ao(3))
fprintf('Kalman,            %.3f        %.3f        %.3f\n',E_kf(1),E_kf(2),E_kf(3)) 
fprintf('Drag model,        %.3f        %.3f        %.3f\n',E_dm(1),E_dm(2),E_dm(3))
