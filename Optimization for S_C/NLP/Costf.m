%%% The cost function belonging to the NonLinear Programming exercise for
%%% Optimization in Systems and Control. 
function [y] = Costf(r)
%% Parameters
global nlc

tau     = 10/3600;              % [h]
mu      = 80;                   % [km^2/h]
Cr      = 2000;                 % [veh/h]
rho_m   = 120;                  % [veh/km/lane]
K       = 10;                   % model propert
a       = 2;                    % model property
vf      = 110;                  % [km/h]
rho_c   = 28;                   % [veh/km/lane]
E1      = (3+8)/2;
E2      = (5+9)/2;
E3      = (3+2)/2;
lambda  = 3;                    % [lanes]
L       = 1;                    % [km]
T       = 600/3600;             % [h]
Dr      = 1500;                 % [veh/h]
segments= 4;                    
steps   = round(T/tau);         % [#]
T = tau;
%% Initials
rho_0   = 20;                   % [veh/km]
v_0     = 90;                   % [km/h]
q0(1:12) = 7000 + 100*E1; q0(13:steps) = 2000 + 100*E2;
v = v_0 * ones(segments,steps+1);
rho = rho_0 * ones(segments,steps+1);
wr(1) = 0;
for k=1:steps
%% Density equations
        qr(k) = min([r(k)*Cr, Dr + wr(k)/tau, Cr*(rho_m - rho(4,k))/(rho_m - rho_c)]);
        rho(1,k+1) = rho(1,k) + tau/(lambda*L)*(q0(k) - lambda*rho(1,k)*v(1,k));
        rho(2,k+1) = rho(2,k) + tau/(lambda*L)*(lambda*rho(1,k)*v(1,k) - lambda*rho(2,k)*v(2,k));
        rho(3,k+1) = rho(3,k) + tau/(lambda*L)*(lambda*rho(2,k)*v(2,k) - lambda*rho(3,k)*v(3,k));
        rho(4,k+1) = rho(4,k) + tau/(lambda*L)*(lambda*rho(3,k)*v(3,k) - lambda*rho(4,k)*v(4,k) + qr(k));
%% Velocity equations
        v(1,k+1) = v(1,k) + (vf*exp(-1/a*(rho(1,k)/rho_c)^a) - v(1,k)) - mu/L*(rho(2,k)-rho(1,k))/(rho(1,k)+K);
        v(2,k+1) = v(2,k) + (vf*exp(-1/a*(rho(2,k)/rho_c)^a) - v(2,k)) - mu/L*(rho(3,k)-rho(2,k))/(rho(2,k)+K) + tau/L*v(2,k)*(v(1,k) - v(2,k));
        v(3,k+1) = v(3,k) + (vf*exp(-1/a*(rho(3,k)/rho_c)^a) - v(3,k)) - mu/L*(rho(4,k)-rho(3,k))/(rho(3,k)+K) + tau/L*v(3,k)*(v(2,k) - v(3,k));
        v(4,k+1) = v(4,k) + (vf*exp(-1/a*(rho(4,k)/rho_c)^a) - v(4,k)) + tau/L*v(4,k)*(v(3,k) - v(4,k));
%% Queue equation
        wr(k+1) = wr(k) + tau*(Dr - qr(k));
%% Output equation
        y(k) = tau*wr(k) + tau*L*lambda*sum(rho(:,k)); 
%% On-ramp queue penalty
        if wr(k) > 20 - E3 && nlc == 1
            y(k) = y(k) + 1000000;
        end
end
y(k+1) = tau*wr(k+1) + tau*L*lambda*sum(rho(:,k+1));
if wr(k+1) > 20 - E3 && nlc == 1
    y(k+1) = y(k+1) + 1000000;
end
y = sum(y);
end