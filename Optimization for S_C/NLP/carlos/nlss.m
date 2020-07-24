function [rho, v, wr, y, qr] = nlss(rho, v, k, wr, q0, xe, y, qr)
    %% Parameters
tau = 10; % h
mu = 80; % km^2/h
Cr = 2000; %veh/h
rho_m = 120; %veh/km lane
K = 10;
a = 2;
vf = 110; % km/h
rho_c = 28; %veh / km lane
Dr = 1500; %veh / h
T = 10 / 3600; % h
L = 1; % km
lambda = 3;
N = 60;

% Inputs
rho0 = 20;
v0 = 90;

% Student parameters
E1 = (8 + 3)/2;
E2 = (9 + 5) / 2;
E3 = (2 + 3) / 2;


    qr(k) = min([xe(k) * Cr, Dr + wr(k) / T, Cr * (rho_m - rho(4, k)) / (rho_m - rho_c)]);

    rho(1,k + 1) = rho(1,k) * (1 - T/L * v(1,k)) + T / (lambda * L) * q0(k); % hier zou een lambda moeten staan
    rho(2,k + 1) = rho(2,k) * (1 - T/L * v(2,k)) + T / L * v(1, k) * rho(1, k);
    rho(3,k + 1) = rho(3,k) * (1 - T/L * v(3,k)) + T / L * v(2, k) * rho(2, k);
    rho(4,k + 1) = rho(4,k) * (1 - T/L * v(4,k)) + T / L * v(3, k) * rho(3, k) + qr(k) * T / (lambda * L);

    for i = 1 : 4
        V(i) = vf * exp(-(1/a) * (rho(i, k) / rho_c)^a);
    end
    
    v(1, k + 1) = v(1, k) * (1 - T/tau) + V(1) * T / tau - mu*T/(tau*L) * (rho(2, k) - rho(1, k))/(rho(1, k) + K);
    v(2, k + 1) = v(2, k) * (1 - T/tau + T/L * v(1, k) - T/L * v(2,k)) + V(2) * T / tau - mu*T/(tau*L) * (rho(3, k) - rho(2, k))/(rho(2, k) + K);
    v(3, k + 1) = v(3, k) * (1 - T/tau + T/L * v(2, k) - T/L * v(3,k)) + V(3) * T / tau - mu*T/(tau*L) * (rho(4, k) - rho(3, k))/(rho(3, k) + K);
    v(4, k + 1) = v(4, k) * (1 - T/tau + T/L * v(3, k) - T/L * v(4,k)) + V(4) * T / tau;
    
    
    wr(k + 1) = wr(k) + T * (Dr - qr(k));
    y(k) = T * (wr(k) + lambda * L * sum(rho(:, k)));
    
end