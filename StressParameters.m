% Get the parameters for the stress model

function [param, IC, f] = StressParameters(t_int,n_int,f_level)
% Lay out parameters from paper

% Constant intervention or multiple
param.t_intervention = t_int; % Start with a value of 25
param.n_int          = n_int;     
param.muS    = 0.09;
param.Sref   = 5;
param.alpha  = 0.33;
param.beta   = 0.5;
param.a3     = 0.001;
param.a4     = 4;
param.Hinf   = 20;
param.v1     = 3;
param.v2     = 1;
param.c3     = 10;
param.kC     = 0.03;
param.kH     = 3.5;
param.kI     = 0.2;
param.muM    = 0.011;
param.kS     = 0.0075;
param.SCrit  = 6.0;
param.eta1   = 0.75;
param.gamma3 = 0.75;
param.c2     = 1;
param.kM     = 0.1;
param.muC    = 0.05;
param.a1     = 0.1;
param.a2     = 0.3;
param.gamma4 = 0.5;
param.c1     = 30;
param.muH    = 0.05;
param.tau    = 0.2;
param.Imax   = 1.0;


%% Initial conditions
S0  = 7.5;
M0  = 5.0;
C0  = 100.0;
H0  = 0.0;
I0  = 1.0;

IC = [S0,M0,C0,H0,I0];

%% stress factors
f = ones(6,1).*f_level;


end