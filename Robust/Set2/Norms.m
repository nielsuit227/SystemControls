%%% This script calculates the N2 and Ninf norm for an inverted notch
%%% filter.
%% First notch filter
N = tf([1 2 1],[1 0.2 1]);
Ninf = norm(N,inf)
N2 = norm(N,2)
%% For which b1 b2 is Ninf finite?
