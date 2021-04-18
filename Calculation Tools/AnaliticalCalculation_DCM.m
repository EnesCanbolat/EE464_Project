clc 
clear
%% Flyback General Components
%% DCM Operation
V_out=12; %V 
R=1.44; % Extra Info
f=65000; % Hz
P_out = 100; %W
P_in = 1*P_out; % W %100 efficiency
I_out = P_out/V_out; %A
Vdc_min = 220; % V
Vdc_max = 400; % V
N=30; % Primary/Secondary
xmax=(V_out/Vdc_max)*N; % for CCM boundary calculation
D_maxV=xmax/(xmax+1); % Maximum Voltage is applied
Lm_max= ((1-D_maxV)^2*R*N^2)/(2*f); % H Max Lm value for DCM
Lm=Lm_max/2; % It can be changed
% Maximum input voltage is taken into consideration
V_in=Vdc_max; % It can be changed
D=(V_out/V_in)*sqrt(2*Lm*f/R);
D_I_lm=(V_in*D/f*Lm); % A Current Ripple in I_lm
I_lm_max=D_I_lm; % Max point of I_lm
I_lm_min=0; % Min point of I_lm
D_V_out_ESR=V_out*0.04; % It is given in description of the project
rc_max=D_V_out_ESR/(I_lm_max*N); % ohm Max ESR value of the capacitor