%% Eren ÖZKARA 2232551
clc
clear
fsw=100000; % Hz
Vin=linspace(220,400,181);
Pout=100; % W
Vout=12; % V
Pin=Pout/0.8; % %80 efficiency is assumed
Iin=Pin./Vin;
Iout=Pout/Vout;
Vsw=Vin+4.33*Vout; % V
% MOSFET
R_on= 0.5 ; % ohm
trisefall_M=19e-9; % s
E_coss=2.2e-6; % Joule
Vgs_M=3.5; % V
Q_g_M=18.7e-9; % C
Irr_M=12; % A
trr_M=180e-9; % s

P_on_M= Iin.^2*R_on;
P_sw_M=0.5*Vsw.*Iin*trisefall_M*fsw;
P_coss_M=E_coss*fsw;
P_G_M=Q_g_M*Vgs_M*fsw;
P_body_M=0.5*Vsw*Irr_M*trr_M*fsw;

% Output Diode
Vf=0.85; %V
P_on_D=Vf*Iout;

% Transformer
% Core Loss Calculation
a=2.3;
x=1.43;
B_op=0.2;
y=2.88;
V_core=1930e-9; %m3

P_core=2*a*(fsw^x)*(B_op^y)*V_core;

%Shunt Resistor
Rshunt=0.01; % ohm
Ishunt=linspace(1.34,0.9858,181);
Pshunt=Ishunt.^2*Rshunt;

%% Plotting
plot(Vin,P_on_M)
hold on
plot(Vin,P_sw_M)
hold on
plot(Vin,P_coss_M*ones(1,181))
hold on
plot(Vin,P_G_M*ones(1,181))
hold on
% plot(Vin,P_body_M)
% hold on
plot(Vin,P_on_D*ones(1,181))
hold on
plot(Vin,P_core*ones(1,181))
hold on
plot(Vin,Pshunt)
hold on
P_total=P_on_M+P_sw_M+P_coss_M*ones(1,181)+P_G_M*ones(1,181)+P_on_D*ones(1,181)+P_core*ones(1,181)+Pshunt;% No body diode
plot(Vin,P_total)
legend('Pon_M','Psw_M','Pcoss_M','PG_M','Pon_D','Pcore','Pshunt','Ptotal') % No body diode
xlabel('Input Voltage (V)')
ylabel('Power Loss (W)')
title(' Power Loss wrt Vin')