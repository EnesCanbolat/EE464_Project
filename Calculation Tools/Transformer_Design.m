clc
clear
%% Project Statement
Vin_min=220; %V
Vin_max=400; %V
Pout=100; % W
Vout=12; % V
V_F=1; % V Secondary Side diode on voltage
fsw_min=55000; % Hz
fsw_max=90000; % Hz
%% Setting a flyback voltage
VO=Vout+V_F; % V Voltage at secondary side
Nptos=5; % Select turn ratio primary/secondary
VOR=VO*Nptos; % Output reflected Voltage
D_max= VOR/(Vin_min+VOR); % Maximum Duty Cycle

%% Calculate secondary winding Ls and secondary-side peak current Ispk
Iout_max=Pout/Vout; % To provide for a margin
Ls_max=((Vout+V_F)*(1-D_max)^2)/(2*Iout_max*fsw_max); %Ls should be lower than this value
Ispk=(2*Iout_max)/(1-D_max);
Ls=5.1e-6;
%% Calculating the primary winding inductance Lp and primary peak current Ippk
Lp=Ls*(Nptos^2);
Ippk=Ispk/Nptos;

%% Determining the transformer size
Ae=111e-6; %m2 PC47EI30
Bsat=0.42; % T
AL= 200e-9; % H/turn2
%% Calculating the primary winding turns Np
NpH=Lp*Ippk/(Ae*Bsat); % Np sould be higher than this value
Np_N=sqrt(Lp/AL); % turn
Np=round(Np_N); % it should be integer
MMF=Nptos*Ippk; %  NI value

%% Calculating the secondary winding turns Ns
Ns=Np/Nptos; % turn
Ns=round(Ns); % it should be integer

%% Calculating the VCC winding turns Nd
Vcc=12; % V
V_F_Vcc= 1; % V
Nd= Ns*(Vcc+V_F_Vcc)/(Vout+V_F); % VCC winding turns
%% Calculating Winding Factor
A=30e-6; %m
D=10.7e-6; %m
F=16.25e-6; %m
Window_A=(A-D)/2*F; %m^2
AWG10= 5.26e-12; %m^2
AWG20= 0.518e-12; %m^2
Cable_A=AWG20*Np+AWG10*2*Ns; %m^2
Fill_Factor=Cable_A/Window_A; 
