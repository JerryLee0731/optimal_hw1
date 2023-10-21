% feedforward net training and prediction demo for 1d problem
% NTU, ME, SOLab
% 2022/09/27

clc; clear; close all;
%% Step 0: Load data file
% x: 200 points between 0 and 2
% y: 200 points
load('OneDimensional_data.mat');

%% Step 1: Polt the original data
figure(1);
plot(x,y,'.');
hold on;
% ----- to do -----

%% Step 2: Modeling through the all data.
% Construct a feedforward network with one hidden layer of size 10.
% ----- to do -----
net = feedforwardnet(10);%'trainlm'

% Train the network net using the training data.
% Hint: Input will be a row vector. (1*n matrix)
% ----- to do -----
net = train(net,x',y');

% Estimate the targets using the trained network.
% ----- to do -----
y_ffwn = net(x');
y_ffwn = y_ffwn';

% Plot the estimation in the interval [0,2].
% ----- to do -----
plot(x, y_ffwn);

%% Step 3: Estimate error (known model)
figure(2);
y_origin = (1.7*x.^5-6.2*x.^4+6.3*x.^3-2.3*x+1.1);

% Estimate error 
% ----- to do -----
y_err = sqrt((y_ffwn - y_origin).^2)./y_origin.*100;

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
    net_wo_i = feedforwardnet(10);
    net_wo_i = train(net_wo_i, x_wo_i', y_wo_i');
    y_ffwn_wo_i = net_wo_i(x');
    y_ffwn_wo_i = y_ffwn_wo_i';

    % Estimate error between model prediction and provided data 
    % ----- to do -----
    y_err_wo_i(i,1) = sqrt( ( y_ffwn_wo_i(i,1) - y(i,1) ).^2 )./y(i,1).*100;

end
% Polt error with respect to each model 
% ----- to do -----
figure(3)
plot(x, y_err_wo_i, '.');

figure(4)
hist(y_err_wo_i, 10);
