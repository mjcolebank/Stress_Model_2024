%% Run the stress model;
clear; clc; close all;
%%
t_int = 500;
n_int = 3;

tstart = 0.0;
tend = 2000;
dt = 0.2;
tspace = tstart:dt:tend;

f_level = 0;
[param, IC, f] = StressParameters(t_int,n_int,f_level);
[t,ylow] = ode23s(@StressModel,tspace,IC,[],param,f);

f_level = 0.5;
[param, IC, f] = StressParameters(t_int,n_int,f_level);
[t,ymed] = ode23s(@StressModel,tspace,IC,[],param,f);

f_level = 1;
[param, IC, f] = StressParameters(t_int,n_int,f_level);
[t,yhigh] = ode23s(@StressModel,tspace,IC,[],param,f);

%% 
Plot_Names = {'Stress','Inflammation','Control','Healing'};
figure(1);clf;
for i=1:4
    subplot(2,2,i); hold on;
    plot(t,ylow(:,i),'g','LineWidth',3);
    plot(t,ymed(:,i),'b','LineWidth',3);
    plot(t,yhigh(:,i),'r','LineWidth',3);
    ylabel(Plot_Names{i}); grid on;
    set(gca,'FontSize',20);
    yyaxis('right');
    plot(t,yhigh(:,5),'--k','LineWidth',2);

end
figure(2);clf;
plot(t,ylow(:,5),'g','LineWidth',3);
plot(t,ymed(:,5),'b','LineWidth',3);
plot(t,yhigh(:,5),'r','LineWidth',3);
ylabel('Intervention'); grid on;
    set(gca,'FontSize',20);