
function [f] = fun(x)

%% Parameters
tau = 10 / 3600; % s
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

% Student parameters
E1 = (8 + 3)/2;
E2 = (9 + 5) / 2;
E3 = (2 + 3) / 2;

% Time Steps
N = 60; 

% Initials
rho0 = 20;
v0 = 90;
rho = ones(4,N) * rho0;
v = ones(4, N) * v0;
wr = zeros(1, N);
qr = zeros(1, N);
V = zeros(1, 4);

% Construct the input
q0 = [ones(1, 13) * (7000 + 100 * E1) ones(1, N - 12) * (2000 + 100 * E2)];

% Append a zero for the r(k) strategy as initial condition
xe = [0; x];

% Evaluate the state space response for N steps plus the initial state
for k = 1 : N + 1
    % Find the ramp flow for k
    qr(k) = min([xe(k) * Cr, Dr + wr(k) / T, Cr * (rho_m - rho(4, k)) / (rho_m - rho_c)]);

    % Find the densities for k + 1
    rho(1,k + 1) = rho(1,k) * (1 - T/L * v(1,k)) + T / (lambda * L) * q0(k);
    rho(2,k + 1) = rho(2,k) * (1 - T/L * v(2,k)) + T / L * v(1, k) * rho(1, k);
    rho(3,k + 1) = rho(3,k) * (1 - T/L * v(3,k)) + T / L * v(2, k) * rho(2, k);
    rho(4,k + 1) = rho(4,k) * (1 - T/L * v(4,k)) + T / L * v(3, k) * rho(3, k) + qr(k) * T / (lambda * L);

    % Find the desired velocities for all segments
    for i = 1 : 4
        V(i) = vf * exp(-(1/a) * (rho(i, k) / rho_c)^a);
    end
    
    % Find the velocities per segment
    v(1, k + 1) = v(1, k) * (1 - T/tau) + V(1) * T / tau - mu*T/(tau*L) * (rho(2, k) - rho(1, k))/(rho(1, k) + K);
    v(2, k + 1) = v(2, k) * (1 - T/tau + T/L * v(1, k) - T/L * v(2,k)) + V(2) * T / tau - mu*T/(tau*L) * (rho(3, k) - rho(2, k))/(rho(2, k) + K);
    v(3, k + 1) = v(3, k) * (1 - T/tau + T/L * v(2, k) - T/L * v(3,k)) + V(3) * T / tau - mu*T/(tau*L) * (rho(4, k) - rho(3, k))/(rho(3, k) + K);
    v(4, k + 1) = v(4, k) * (1 - T/tau + T/L * v(3, k) - T/L * v(4,k)) + V(4) * T / tau;
    
    % Find the waiting que
    wr(k + 1) = wr(k) + T * (Dr - qr(k));    
end

% Find the sum of outputs
f = sum(T * (wr + lambda .* L .* sum(rho)));




