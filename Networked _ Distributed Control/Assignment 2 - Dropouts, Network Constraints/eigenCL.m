function [ lambda] = eigenCL(delta, A, B, K, h)

expAh   = [exp(0.6*h) 9*(exp(0.7*h)-exp(0.6*h)); 0 exp(0.7*h)];
Aint    = A\(expAh - eye(2))*B*K;

hl = h*delta;
expAhl   = [exp(0.6*hl) 9*(exp(0.7*hl)-exp(0.6*hl)); 0 exp(0.7*hl)];
expAhlmin   = [exp(0.6*hl-h) 9*(exp(0.7*hl-h)-exp(0.6*hl-h)); 0 exp(0.7*hl-h)];

CL = expAhl - Aint*expAhlmin;

lambda = eig(CL);
end

