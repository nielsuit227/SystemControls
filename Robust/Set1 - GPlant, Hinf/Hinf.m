
%% Mixed-Sensitivity Controller
G11 = G(1,1); G12 = G(1,2); G13 = Gd(1); 
G21 = G(2,1); G22 = G(2,2); G23 = Gd(2);
Wu(1,1) = tf([1]);
Wu(1,2) = tf([1]);
Wp(1,1) = tf([1]);
Wp(1,2) = tf([1]);
systemnames = 'G11 G12 G13 G21 G22 G23 Wu Wp';
inputvar = '[v;beta;tau]';
input_to_G11 = '[beta]';
input_to_G12 = '[tau]';
input_to_G13 = '[v]';
input_to_G21 = '[beta]';
input_to_G22 = '[tau]';
input_to_G23 = '[v]';
input_to_Wu = '[beta;tau]';
input_to_Wp = '[G11+G12+G13;G21+G22+G23]';
outputvar = '[Wp;Wu;G11+G12+G13;G21+G22+G23]';
sysoutname = 'P';
sysic;
[K,CL,GAM,INFO] = hinfsyn(P,2,2);