% kriging fitting and prediction demo for 2d problem
% NTU, ME, SOLab
% 2018/11/05

warning off
clear
close all
clc

% -- sampling

lb = [-1, -1];
ub = [1, 1];

resol = 7;
[x_data1, x_data2] = meshgrid(lb(1,1): ...
    abs(lb(1,1)-ub(1,1))/resol:ub(1,1), lb(1,2):...
    abs(lb(1,2)-ub(1,2))/resol:ub(1,2));

x_data(:,:,1) = x_data1;
x_data(:,:,2) = x_data2;
x_data = reshape(x_data, [], 2);

f_data = GOMEZ(x_data);

% -- fitting kriging

kparam = f_variogram_fit(x_data, f_data, lb, ub);

% -- plot

resol = 50;
[x1, x2] = meshgrid(lb(1,1): ...
    abs(lb(1,1)-ub(1,1))/resol:ub(1,1), lb(1,2): ...
    abs(lb(1,2)-ub(1,2))/resol:ub(1,2));

x(:,:,1) = x1;
x(:,:,2) = x2;
x = reshape(x, [], 2);

f_krig = f_predictkrige(x, kparam);
f_krig = reshape(f_krig, resol+1, resol+1);

figure(1) % -- kriging
hold on
contour(x1, x2, f_krig);
for i = 1:size(x_data, 1)
    plot(x_data(i, 1), x_data(i, 2), 'ro');
end
xlabel('x1')
ylabel('x2')
hold off
axis square

figure(2) % -- real contour
hold on
f_real = GOMEZ(x);
f_real = reshape(f_real, resol+1, resol+1);
contour(x1, x2, f_real);
xlabel('x1')
ylabel('x2')
hold off
axis square

figure(3) % -- real 3d
hold on
meshc(x1, x2, f_real);
xlabel('x1')
ylabel('x2')
zlabel('f')
hold off