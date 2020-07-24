clear
close all
clc
load('FLoatingWindTurbine.mat');
%% Controller
sisocontroller=0.15*tf([100/2/pi 1], [1 0]); % simple controller with positive feedback
%% construct a generalized plant for simulation reasons
warning off
systemnames ='FWT';     % The full wind turbine model
inputvar ='[V; Beta; Tau]';    % Input generalized plant
input_to_FWT= '[Beta; Tau; V]';
outputvar= '[FWT; Beta; Tau; FWT]';    % Output generalized plant also includes the inputs
sysoutname='Gsim';
sysic;
warning on

CL_sisocontroller=minreal(lft(Gsim(1:end-1,1:end-1),sisocontroller)); % SISO controller