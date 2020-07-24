clear all

%machine properties
Ls = 0.085;
Lr = 0.085;
M = 0.082;
Rs = 0.3;
Rr = 0.3;
J = 0.05;
n_nom = 2910; %RPM

%a)
sigma = 1 - M^2 / (Ls*Lr);

%b)
wm_rat = n_nom/60*2*pi; %rad/s

%c)
u_s = 220*sqrt(2);
w_s = 3000/60*2*pi; %rad/s

%i_s_fun = @(wm) (u_s/())

w_mech = (-w_s : 3*w_s/999 : 2*w_s)';
w_slip = (w_s - w_mech);

i_s_fun = @(wslip) (u_s./(Rs+1i*w_s*Ls+M^2*wslip*w_s./(Rr+1i*wslip*Lr)));

% i_s = u_s./(Rs+1i*w_s*Ls+M^2*w_slip*w_s./(Rr+1i*w_slip*Lr));
i_s = i_s_fun(w_slip);

figure(1)
clf
plot(real(i_s),imag(i_s),'-')
set(gcf,'Name','Circle')
xlabel('Real(i_s)')
ylabel('imag(i_s)')

axis([-100 100 -180 0])
axis equal

%special cases
i_s_s2 = i_s_fun(w_s - -w_s); %reverse rotation
i_s_s1 = i_s_fun(w_s - 0); %blocked rotor
i_s_sr = i_s_fun(w_s - wm_rat); %rated speed
i_s_s0 = i_s_fun(w_s - w_s); %synchronous speed
i_s_smin1 = i_s_fun(w_s - 2*w_s); %generating

hold on
plot(real(i_s_s2),imag(i_s_s2),'ro','LineWidth',2)
ht1 = text(real(i_s_s2)-3,imag(i_s_s2)-7,'-w_s');

plot(real(i_s_s1),imag(i_s_s1),'ro','LineWidth',2)
ht2 = text(real(i_s_s1)+5,imag(i_s_s1)-3,'0');

plot(real(i_s_sr),imag(i_s_sr),'ro','LineWidth',2)
ht3 = text(real(i_s_sr)-3,imag(i_s_sr)-8,'w_{rat}');

plot(real(i_s_s0),imag(i_s_s0),'ro','LineWidth',2)
ht4 = text(real(i_s_s0)-3,imag(i_s_s0)-7,'w_s');

plot(real(i_s_smin1),imag(i_s_smin1),'ro','LineWidth',2)
ht5 = text(real(i_s_smin1)-3,imag(i_s_smin1)+6,'2*w_s');

set([ht1 ht2 ht3 ht4 ht5],'FontSize',12)

fprintf('Rated stator current: %0.2f Arms (%0.2f Apeak)\n',abs(i_s_sr)/sqrt(2),abs(i_s_sr))

%% question g-j
p = 1;
Te = 3/2*p*(1-sigma)*Ls*abs(i_s).^2 ./ (Rr./(Lr*w_slip) + w_slip*Lr/Rr);

figure(3)
hold on
plot(w_mech/2/pi*60,Te , w_mech/2/pi*60,abs(i_s)/sqrt(2))

set(gcf,'Name','Torque vs speed and current versus speed')
xlabel('Speed (RPM)')
ylabel('Torque (Nm) or Current (A_r_m_s)')   
set(gca,'XLim',[min(w_mech/2/pi*60) max(w_mech/2/pi*60)])
legend('Torque','Current','location','SouthWest')
grid on

%rated point
w_sl = w_s - wm_rat;
Te_rat = 3/2*p*(1-sigma)*Ls*abs(i_s_sr).^2 ./ (Rr./(Lr*w_sl) + w_sl*Lr/Rr);
hold on
plot(wm_rat/2/pi*60,Te_rat,'or','LineWidth',2)

%print info on maximum torque etc
[maxT, ind] = max(Te);
fprintf('Maximum torque is %0.2f Nm, at %0.1f RPM, or %0.2f rad/s\n',...
   maxT,w_mech(ind)/2/pi*60,w_mech(ind))
[minT, ind] = min(Te);
fprintf('Minimum torque is %0.2f Nm, at %0.1f RPM, or %0.2f rad/s\n',...
   minT,w_mech(ind)/2/pi*60,w_mech(ind))

%% question k
i_s_rat = abs(i_s_sr)

%i_s no longer depends on w_m (becomes a constant instead of a vector)
Te_Idrive = 3/2*p*(1-sigma)*Ls*i_s_rat^2 ./ (Rr./(Lr*w_slip) + w_slip*Lr/Rr);

figure(5)
clf
plot(w_mech/2/pi*60 , [Te Te_Idrive])
set(gcf,'Name','Voltage and current drive')
xlabel('Rotational speed')
ylabel('T_e (Nm)')
   
legend('Voltage drive','Current drive','location','SouthWest')
grid on