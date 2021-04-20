clc
clear
%% Project Statement
Vin_min=220; %V
Vin_max=400; %V
Pout=100; % W
Vout=12; % V
V_F=1; % V Secondary Side diode on voltage
fsw_min=30000; % Hz
fsw_max=40000; % Hz
%% Setting a flyback voltage
VO=Vout+V_F; % V Voltage at secondary side
Nptos=8; % Select turn ratio primary/secondary
VOR=VO*Nptos; % Output reflected Voltage
D_max= VOR/(Vin_min+VOR); % Maximum Duty Cycle

%% Calculate secondary winding Ls and secondary-side peak current Ispk
Iout_max=1.2*Pout/Vout; % To provide for a margin
Ls=((Vout+V_F)*(1-D_max)^2)/(2*Iout_max*fsw_max);
Ispk=(2*Iout_max)/(1-D_max);

%% Calculating the primary winding inductance Lp and primary peak current Ippk
Lp=Ls*(Nptos^2);
Ippk=Ispk/Nptos;

%% Determining the transformer size
Ae=84e-6; % m2 Kool Mu E Core Data 3515
Bsat=1; % T
AL= 146e-9; % H/turn2
%% Calculating the primary winding turns Np
NpH=Lp*Ippk/(Ae*Bsat); % Np sould be higher than this value
Np=sqrt(Lp/AL); % turn
Np=round(Np); % it should be integer
MMF=Nptos*Ippk; %  NI value

%% Calculating the secondary winding turns Ns
Ns=Np/Nptos; % turn
Ns=round(Ns); % it should be integer

%% Calculating the VCC winding turns Nd
Vcc=12; % V
V_F_Vcc= 1; % V
Nd= Ns*(Vcc+V_F_Vcc)/(Vout+V_F); % VCC winding turns

