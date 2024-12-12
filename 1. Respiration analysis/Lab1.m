% --------------------Resample spirometer data---------------------------%

% Load the data/variables from the file named spirometer.txt
spiro = load('spirometer.txt')

% The spirometer data 'spiro' is a 2Nx1 vector
% Resample the spirometer data into 50 Hz
spiro_resampled =resample(spiro, 1, 2);  


% --------------------Predict respiratory airflows---------------------------%





% Load the belt data into Nx2 matrix from the file beltsignals.txt
belt = load('beltsignals.txt'); % Nx2 matrix where column 1 is chest signal, column 2 is abdomen signal

% Load the resampled spirometer data into Nx1 vector from the file spiro_resampled.mat
spiro=load('spirometer.txt');
fs=100;
fd=50;
[p,q]=rat(fd/fs);

spiro_resampled = load('spiro_resampled.mat');


% Load the regression coefficients vector for the model 1 from the file regressioncoefficients1.txt
coeff1 = load('regressioncoefficients1.txt'); % Loads model 1 coefficients

% Load the regression coefficients vector for the model 2 from the file regressioncoefficients2.txt
coeff2 = load('regressioncoefficients2.txt'); % Loads model 2 coefficients

% Load the regression coefficients vector for the model 3 from the file regressioncoefficients3.txt
coeff3 = load('regressioncoefficients3.txt'); % Loads model 3 coefficients

% Extract chest and abdomen signals from the belt matrix
s_ch = belt(:, 1); % chest belt signal
s_ab = belt(:, 2); % abdomen belt signal

% Predict the airflow using model 1 (with coeff1)
flow1 = belt(:, 1) * coeff1(1) + belt(:, 2) * coeff1(2);
% Predict the airflow using model 2 (with coeff2)
flow2 = belt(:, 1) * coeff2(1) + belt(:, 2) * coeff2(2) + belt(:, 1).^2 * coeff2(3) + belt(:, 2).^2 * coeff2(4);
% Predict the airflow using model 3 (with coeff3)
flow3 = belt(:, 1) * coeff3(1) + belt(:, 2) * coeff3(2) + belt(:, 1).*belt(:, 2) * coeff3(3);




% --------------------Evaluate model performances---------------------------%


% Load the data from the file problem3.mat
load('problem3.mat');

% Nx1 vectors flow1, flow2, and flow3 contain the model predictions
% Nx1 vector spiro_resampled contains the resampled reference spirometer data
N=length(spiro_resampled);
% Compute the correlation coefficient for the model 1, between flow1 and spiro_resampled
mean_flow1=mean(flow1);
mean_spiro=mean(spiro_resampled);
corr1 = sum((flow1 - mean_flow1) .* (spiro_resampled - mean_spiro)) / ...
         sqrt(sum((flow1 - mean_flow1).^2) * sum((spiro_resampled - mean_spiro).^2)); 

% Compute the correlation coefficient for the model 2, between flow2 and spiro_resampled
mean_flow2 = mean(flow2);
corr2 = sum((flow2 - mean_flow2) .* (spiro_resampled - mean_spiro)) / ...
         sqrt(sum((flow2 - mean_flow2).^2) * sum((spiro_resampled - mean_spiro).^2));


% Compute the correlation coefficient for the model 3, between flow3 and spiro_resampled
mean_flow3 = mean(flow3);
corr3 = sum((flow3 - mean_flow3) .* (spiro_resampled - mean_spiro)) / ...
         sqrt(sum((flow3 - mean_flow3).^2) * sum((spiro_resampled - mean_spiro).^2));

% Compute the RMSE for the model 1, between flow1 and spiro_resampled
mse1 = mean((flow1 - spiro_resampled).^2);
rmse1 = sqrt(mse1);

% Compute the RMSE for the model 2, between flow2 and spiro_resampled
mse2 = mean((flow2 - spiro_resampled).^2);
rmse2 = sqrt(mse2);

% Compute the RMSE for the model 3, between flow3 and spiro_resampled
mse3 = mean((flow3 - spiro_resampled).^2);
rmse3 = sqrt(mse3);