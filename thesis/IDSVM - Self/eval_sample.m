%%% Script to evaluate one example by a trained SVM. The loaded data should
%%% contain the Lagrangians, the feature selection transformation matrix,
%%% the training data, the kernel width and other possible preprocess
%%% matrices.
function [Yp] = eval_sample(a,K,X_p,X_t,Y_t)
np = size(X_p,1);
nt = size(X_t,1);
for i=1:np
    G = zeros(nt,1);
    for j=1:nt
        G(j) = K(X_p(i,:)',X_t(j,:)');
    end
    Yp(i) = real(((a.*Y_t)'*G));
end

end