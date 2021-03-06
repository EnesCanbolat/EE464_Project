clc
clear
%% Project Statement
Vin_min=220; %V
Vin_max=400; %V
Pout=100; % W
Vout=12; % V
V_F=1; % V Secondary Side diode on voltage
fsw_min=90000; % Hz
fsw_max=100000; % Hz
%% Setting a flyback voltage
VO=Vout+V_F; % V Voltage at secondary side
Nptos=26/6; % Select turn ratio primary/secondary
VOR=VO*Nptos; % Output reflected Voltage
D_max= VOR/(Vin_min+VOR); % Maximum Duty Cycle

%% Calculate secondary winding Ls and secondary-side peak current Ispk
Iout_max=Pout/Vout; % To provide for a margin
Ls_max=((Vout+V_F)*(1-D_max)^2)/(2*Iout_max*fsw_max); %Ls should be lower than this value
Ispk=(2*Iout_max)/(1-D_max);
Ls=4.34e-6;
%% Calculating the primary winding inductance Lp and primary peak current Ippk
Lp=Ls*(Nptos^2);
Ippk=Ispk/Nptos;

%% Determining the transformer size
Ae=41e-6; %m2 PC47EI25
Bsat=0.42; % T
AL= 125e-9; % H/turn2
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
A=25.3e-3; %m
D=6.5e-3; %m
F=12.35e-3; %m
C=5.75e-3; % m
E=19e-3; % m
H=3e-3; % m
Window_A=(A-D)/2*(F+1e-3); %m^2
Window_A2=(A-D-2*H)/2*(F+1e-3); %m^2
AWG10= 5.26e-6; %m^2
AWG20= 0.518e-6; %m^2
AWG30= 0.509e-6; %m^2
Cable_A=AWG20*Np+AWG10*Ns +AWG30*Nd; %m^2
Fill_Factor=Cable_A/Window_A; 

%% Skin Effect and AC resistance Without Litz Wire
% p=1.678e-8; % ohm.m resistivity
% u=0.99*pi*4e-7; % H/m The absolute magnetic permeability 
% f=100000; % Hz 
% l=(C+(D+E)/2)*2; % Length of the conductor in mm
% AWG10_l=l*Ns; %
% AWG20_l=l*Np; % 
% AWG30_l=l*Nd; % 
% AWG10_d=2.588e-3; % m diameter
% AWG20_d=0.812e-3; % m diameter
% AWG30_d=0.255e-3; % m diameter
% Skin_depth=sqrt(p/(pi*f*u));
% A_eff_AWG10=Skin_depth*pi*AWG10_d; % the effective cross sectional area used in mm
% A_eff_AWG20=Skin_depth*pi*AWG20_d;
% A_eff_AWG30=Skin_depth*pi*AWG30_d;
% R_AC_10=p*AWG10_l/A_eff_AWG10; %  AC resistance 
% R_AC_20=p*AWG20_l/A_eff_AWG20;
% R_AC_30=p*AWG30_l/A_eff_AWG30;
%% Litz Wire
l=(C+(D+E)/2)*2; % Length of the conductor in mm
AWG10_l=l*Ns; %
AWG20_l=l*Np; % 
AWG30_l=l*Nd; % 

% AWG10: 5x3/44/38 , AWG10 construction from AWG38 litz wire
% AWG20: 3/22/38, AWG20 construction from AWG38 litz wire
% AWG30: 7/38, AWG30
% Rdc=(RS*((1.02)^Nb)*((1.03)^Nc))/Ns
% Rs= Max. DC resistance of indv. strands
% Nb= Number of bunching operations (x indicates bunching)
% Nc= Number of cabling operations (/ indicates cabling)
% Ns= Number of indivudial strands
Rs38=681.9;
Nb10=1; Nc10=2; Ns10=5*3*44;
Rdc10=(Rs38*((1.02)^Nb10)*((1.03)^Nc10))/Ns10; %ohms/1000ft for AWG10, DC
Nb20=0; Nc20=2; Ns20=3*22;
Rdc20=(Rs38*((1.02)^Nb20)*((1.03)^Nc20))/Ns20 ;%ohms/1000ft for AWG20, DC
Nb30=0; Nc30=1; Ns30=7;
Rdc30=(Rs38*((1.02)^Nb30)*((1.03)^Nc30))/Ns30; %;ohms/1000ft for AWG30, DC
RDC1=(Rdc10/1000)*(1/0.3048); % ohm per meter
RDC2=(Rdc20/1000)*(1/0.3048); % ohm per meter
RDC3=(Rdc30/1000)*(1/0.3048); % ohm per meter

RDC10=RDC1*AWG10_l;
RDC20=RDC2*AWG20_l;
RDC30=RDC3*AWG30_l;
