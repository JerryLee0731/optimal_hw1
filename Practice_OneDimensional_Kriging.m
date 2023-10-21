% kriging fitting and prediction demo for 1d problem
% NTU, ME, SOLab
% 2022/09/27

clc; clear; close all;
%% Step 0: Load data file
% x: 200 points between 0 and 2
% y: 200 points
load('OneDimensional_data.mat');
lb = 0;
ub = 2;

addpath("kriging demo\code\")

%% Step 1: Polt the original data
figure(1);
% ----- to do -----

%% Step 2: Modeling through the all data.
% Fitting kriging
% Hint: parameter = f_variogram_fit(data x, data y, lb, ub);
% ----- to do -----
parameter = f_variogram_fit(x, y, lb, ub);

% Kriging prediction.
% Hint: Kriging prediction = f_predictkrige(data x, parameter);
% ----- to do -----
y_prediction = f_predictkrige(x, parameter);

% Plot the kriging average in the interval [0,2].
% ----- to do -----
plot(x,y,'.');
hold on;
plot(x,y_prediction);

%% Step 3: Estimate error (known model)
figure(2);
y_origin = (1.7*x.^5-6.2*x.^4+6.3*x.^3-2.3*x+1.1);

% Estimate error 
% ----- to do -----
y_err = sqrt((y_prediction - y_origin).^2)./y_origin.*100;

% Plot error with respect to x  
% ----- to do -----
plot(x, y_err, '.');

%% Step 4: Estimate error (unknown model, leave one out)
% Leave one out: Take out the 1 sample, and model through the remaining n-1 data.
% Generate 200 models.
for i = 1:size(y,1) 
    % Take out the ith sample.
    % ----- to do -----
    x_wo_i = x([1:i-1, i+1:200]);
    y_wo_i = y([1:i-1, i+1:200]);

    % Modeling through the remaining 199 data. (similar Step 2)
    % ----- to do -----
    parameter_wo_i = f_variogram_fit(x_wo_i, y_wo_i, lb, ub);
    y_prediction_wo_i = f_predictkrige(x, parameter_wo_i);

    % Estimate error between model prediction and provided data 
    % ----- to do -----
    y_err_wo_i(i,1) = sqrt( ( y_prediction_wo_i(i,1) - y(i,1) ).^2 )./y(i,1).*100;

end
% Polt error with respect to each model 
 % ----- to do -----
figure(3)
plot(x, y_err_wo_i, '.');

figure(4)
hist(y_err_wo_i, 10);
