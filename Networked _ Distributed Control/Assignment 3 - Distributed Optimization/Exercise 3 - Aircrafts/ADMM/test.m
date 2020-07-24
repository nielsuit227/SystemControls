u = sdpvar(2,1);
x1 = 5*u(1);
x2 = -6*u(2);
cons = u'*u <= 1;
opts = sdpsettings('verbose',0);
sol = optimize(cons,x1+x2,opts);
X = value(u)