% Stress model from Vodovotz et al. 2024


function dy = StressModel(t,y,param,f)

% Unpack variables
S = y(1);
M = y(2);
C = y(3);
H = y(4);
I = y(5);

%% Construct terms for each ODE component
% S
fsum = sum(f);
S_hill_numer = param.a3*(M./(1+(H./param.Hinf).^2)).^2;
S_hill_denom = (param.a4.^2) + (M./(1+(H./param.Hinf).^2)).^2;
S_alpha      = param.alpha*( fsum./(1+I)) + param.beta;
dS = -param.muS*(S - param.Sref*S_alpha) + S_hill_numer./S_hill_denom;

% M
M_denom = (param.v2+S)*(param.c3 + param.kC*C + param.kH*H + param.kI*I);
dM = (param.v1*S)./M_denom - param.muM*M;

% C
C_term = (param.eta1*H + param.gamma3*I)/(param.c2 + param.kM*M);
dC = param.kS*S*(param.SCrit - S) + C_term - param.muC*C;

% H
H_term = (param.a1*M + param.a2*C + param.gamma4*I)/(param.c1 + param.a1*M + param.a2*C + param.gamma4*I);
dH = H_term - param.muH*H;

% I terms
t_int = param.t_intervention;
n_int = param.n_int;
if n_int==1
    % I terms: long-term intervention
    I_term = param.Imax/(1 + exp(t - param.t_intervention));
    dI = (I_term - I)./param.tau;
else
    % I terms: short-term interventions
    I_term = zeros(n_int,1);
    t_int = param.t_intervention;
    for i=1:n_int
        exp_1 = (2*i-1)*t_int-t;
        exp_2 = t-2*i*t_int;
        I_term(i) = 1/(1+exp(exp_1))/(1+exp(exp_2)) - I;
    end
    dI = n_int*param.Imax*sum(I_term)/param.tau;
end
%% ODEs
dy = [dS; dM; dC; dH; dI];

end