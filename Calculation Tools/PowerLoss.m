%% Eren ÖZKARA 2232551
clc
clear
fsw=linspace(102000,101000,181); % Hz
Vin=linspace(220,400,181);
Pout=100; % W
Vout=12; % V
Pin=Pout/0.8; % %80 efficiency is assumed
Iin=Pin./Vin;
Iout=Pout/Vout;
Vsw=Vin+4.33*Vout; % V % 4.33 is turn ratio

% MOSFET
R_on= 0.5 ; % ohm
trisefall_M=19e-9; % s
E_coss=2.2e-6; % Joule
Vgs_M=3.5; % V
Q_g_M=18.7e-9; % C


P_on_M= Iin.^2*R_on;
P_sw_M=0.5*Vsw.*Iin*trisefall_M.*fsw;
P_coss_M=E_coss.*fsw;
P_G_M=Q_g_M*Vgs_M.*fsw;


% Output Diode
Vf=0.75; %V
P_on_D=Vf*Iout;

%Shunt Resistor
Rshunt=0.01; % ohm
Ishunt=linspace(1.34,0.9858,181); % rms value dependency on Vin
Pshunt=Ishunt.^2*Rshunt;

% Transformer
% Core Loss Calculation
a=2.3;
x=1.43;
B_op=0.2;
y=2.88;
V_core=1930e-9; %m3
P_core=2*a.*(fsw.^x)*(B_op^y)*V_core;
% Copper Loss Calculation
Id= 0.005; % A third winding
RAC10=8.1431e-04; % ohm
RAC20=0.0346; % ohm
RAC30=0.0731; % ohm
P_copper=Iout^2*RAC10+Ishunt.^2*RAC20+Id^2;

%RCD Snubber
Isnubber=linspace(0.01299,0.01280,181);
Psnubber=Isnubber.^2.*5600+Isnubber*0.6;


%% Plotting
P_MOSFET=P_on_M+P_sw_M+P_coss_M.*ones(1,181)+P_G_M.*ones(1,181);
P_Diode=P_on_D*ones(1,181);
P_total=P_on_M+P_sw_M+P_coss_M.*ones(1,181)+P_G_M.*ones(1,181)+P_on_D.*ones(1,181)+P_core.*ones(1,181)+Pshunt+P_copper+Psnubber;
P_transformer=P_copper + P_core;
plot(Vin,P_total,'LineWidth',2)
hold on
plot(Vin,P_MOSFET,'LineWidth',2)
hold on
plot(Vin,P_Diode,'LineWidth',2)
hold on
plot(Vin,P_transformer,'LineWidth',2)
hold on
plot(Vin,Psnubber,'LineWidth',2)

legend('Total','MOSFET','Diodes','Transformer','RCD Snubbber') 
xlabel('Input Voltage (V)')
ylabel('Power Loss (W)')
title(' Power Loss vs Vin')
ylim([0 9.5])
grid on

figure
eff=(100./(P_total+100)).*100;
plot(Vin,eff,'LineWidth',2)

xlabel('Input Voltage (V)')
ylabel('%')
title(' Efficiency vs Vin')
grid on
ylim([91.6 92])

