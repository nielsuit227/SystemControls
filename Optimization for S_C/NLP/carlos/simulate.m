function simulate(x)
close all;
N = 60; %timesteps

    parameters;

% Initials
rho = ones(4,N) * rho0;
v = ones(4, N) * v0;
wr = zeros(1, N);
q0 = [ones(1, 13) * (7000 + 100 * E1) ones(1, N - 12) * (2000 + 100 * E2)];
xe = [0; x];
qr = 0;
y=0;
    for k = 1 : N
        [rho, v, wr, y, qr] = nlss(rho, v, k, wr, q0, xe, y, qr);
    end
    figure;
    subplot(2,1,1);
    plot(1:N, x);
    subplot(2,1,2);
    plot(1:N, y);
    figure;
    bar3(flip(rho)-28);
    fprintf('Y = %f\n', sum(y));
    wr = wr(2:end);
    figure;
    plot(1:N, qr, 1:N, wr * 10);
    
    
   
    %figure;
    %bar3(rho');
    
end