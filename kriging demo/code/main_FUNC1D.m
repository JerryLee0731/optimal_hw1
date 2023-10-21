% kriging fitting and prediction demo for 1d problem
% NTU, ME, SOLab
% 2018/11/05

warning off
clear
close all
clc

% -- sampling

lb = 0;
ub = 10;

x_data = linspace(0, 10, 8)';
f_data = FUNC1D(x_data);

% -- fitting kriging

kparam = f_variogram_fit(x_data, f_data, lb, ub);

% -- plot

x = [lb:(ub-lb)/100:ub]';

f_real = FUNC1D(x);
[f_krig, sigma] = f_predictkrige(x, kparam); % kriging prediction
f_krig_p_sigma = f_krig + sigma;
f_krig_m_sigma = f_krig - sigma;

figure(1)
hold on

p1 = plot(x, f_real, 'r--'); p1.Color(4) = 0.5; % real
plot(x, f_krig, 'b-') % kriging average
p2 = plot(x, f_krig_p_sigma, 'g-.'); p2.Color(4) = 0.5; % kriging average plus sigma
p3 = plot(x, f_krig_m_sigma, 'g-.'); p2.Color(4) = 0.5; % kriging average minus sigma

x2 = [x', fliplr(x')];
between = [f_krig_p_sigma', fliplr(f_krig_m_sigma')];
h = fill(x2, between, 'g', 'LineStyle', 'none'); set(h, 'facealpha', .1);

for i = 1:size(x_data, 1) % data
    plot(x_data, f_data, 'ro')
end

xlabel('x')
ylabel('f')

hold off
axis square
