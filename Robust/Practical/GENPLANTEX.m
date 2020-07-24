systemnames = 'G Wp Wu';
inputvar = '[w(2);u(2)]';
input_to_G = '[u]';
input_to_Wp = '[w+G]';
input_to_Wu = '[u]';
outputvar = '[Wp;Wu;G+w]';
sysoutname = 'P';
sysic;
[K_h,CL_mimo,Ninf,INFO] = hinfsyn(P,2,2);