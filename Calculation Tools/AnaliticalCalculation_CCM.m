clc 
clear
%% Flyback General Components
%% CCM Operation
V_out=12; %V 
R=1.44; % Extra Info
f=98000; % Hz
P_out = 100; %W
P_in = 1*P_out; % W %100 efficiency
I_out = P_out/V_out; %A
Vdc_min = 220; % V
Vdc_max = 400; % V
N=4; % Primary/Secondary
xmin=(V_out/Vdc_min)*N; % to easily see
xmax=(V_out/Vdc_max)*N; % to easily see
D_minV=xmin/(xmin+1); % Minimum Voltage is applied
D_maxV=xmax/(xmax+1); % Maximum Voltage is applied
Lm_min= ((1-D_maxV)^2*R*N^2)/(2*f); % H Worst case is taken into consideration
Lm=81.6e-6; % It can be changed

% Maximum input voltage is taken into consideration
V_in=Vdc_max; % It can be changed
D=D_maxV;
I_in=P_in/V_in;
I_lm= I_in/D;
D_I_lm=(V_in*D)/(f*Lm); % A Current Ripple in I_lm
I_lm_max=I_lm+D_I_lm/2; % Max point of I_lm
I_lm_min=I_lm-D_I_lm/2; % Min point of I_lm
V_sw_open= V_in+V_out*N; % Switch Voltage when switch is open
D_V_out=V_out*0.04; % It is given in description of the project
C_min_ideal=D/(R*f*D_V_out); % F Required Minumum Capacitance in ideal case
D_V_out_ESR=V_out*0.04; % It is given in description of the project
rc_max=D_V_out_ESR/(I_lm_max*N); % ohm Max ESR value of the capacitor


