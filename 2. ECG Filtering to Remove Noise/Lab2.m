% --------------------Load and select data---------------------------%
% The sampling rate is 1000 Hz
FS = 1000;

% Load ECG 1 into Nx1 vector from the file ecg_signal_1.dat
ecg1 =load('ecg_signal_1.dat'); 

% Load ECG 2 into Nx1 vector from the file ecg_signal_2.dat
ecg2 =load('ecg_signal_2.dat'); 

% Select the interval [2 s, 3s] samples from ECG 1
ecg1_interval =ecg1([2*FS:1:3*FS]); 

% Sample times for the interval 1
ecg1_interval_t =[2:1/FS:3]; 

% Select the interval [1 s, 2s] samples from ECG 2
ecg2_interval =ecg2([1*FS:2*FS]);  

% Sample times for the interval 2
ecg2_interval_t =[1:1/FS:2];  


% --------------------Compute power spectrum---------------------------%

% The sampling rate is 1000 Hz
FS = 1000;

% Load ECG 1 into Nx1 vector from the file ecg_signal_1.dat
ecg1 =load('ecg_signal_1.dat'); 

% Load ECG 2 into Nx1 vector from the file ecg_signal_2.dat
ecg2 =load('ecg_signal_2.dat'); 

% Compute ECG 1 power spectrum
N1 = length(ecg1);
P_ecg1 = (1/N1) *fft(ecg1).*conj(fft(ecg1));

% Compute ECG 2 power spectrum
N2 = length(ecg2);
P_ecg2 = (1/N2) *fft(ecg2).*conj(fft(ecg2));

% Compute power spectrum frequency bins from 0 Hz to the Nyquist frequency
% For ECG 1
f1 =[0:FS/N1:FS/2]; 
% ...and for ECG 2
f2 =[0:FS/N2:FS/2];

% --------------------Moving average filtering---------------------------%

% The sampling rate is 1000 Hz
FS = 1000;

% Load ECG 1 into Nx1 vector from the file ecg_signal_1.dat
ecg1 =load('ecg_signal_1.dat'); 

% Load ECG 2 into Nx1 vector from the file ecg_signal_2.dat
ecg2 =load('ecg_signal_2.dat'); 

% Create moving average filter coefficients a and b:
b =  1/10.*ones(1,10);
a =  1;
    
% Do the filtering using a, b, and ecg1
% For ecg1
ecg1_filtered =filter(b,a,ecg1); 
% ...and ecg2
ecg2_filtered =filter(b,a,ecg2); 


% --------------------Derivative based filtering---------------------------%

% The sampling rate is 1000 Hz
FS = 1000;

% Load ECG 1 into Nx1 vector from the file ecg_signal_1.dat
ecg1 =load('ecg_signal_1.dat'); 

% Load ECG 2 into Nx1 vector from the file ecg_signal_2.dat
ecg2 =load('ecg_signal_2.dat'); 

% Create derivative based filter coefficients a and b:
N1 = length(ecg1);
N2 = length(ecg2);
b = [1,-1];
a = [1,-0.995];

b = b/max(freqz(b,a,[],FS));
    
% Do the filtering using a, b, and ecg1
% For ecg1
ecg1_filtered =filter(b, a, ecg1); 
% ...and ecg2
ecg2_filtered =filter(b, a, ecg2); 


% --------------------Derivative based filtering---------------------------%
% The sampling rate is 1000 Hz
FS = 1000;

% Load ECG 1 into Nx1 vector from the file ecg_signal_1.dat
ecg1 =load('ecg_signal_1.dat'); 

% Load ECG 2 into Nx1 vector from the file ecg_signal_2.dat
ecg2 =load('ecg_signal_2.dat'); 

% Create derivative based filter coefficients a and b:
N1 = length(ecg1);
N2 = length(ecg2);
b = [1,-1];
a = [1,-0.995];

b = b/max(freqz(b,a,[],FS));
    
% Do the filtering using a, b, and ecg1
% For ecg1
ecg1_filtered =filter(b, a, ecg1); 
% ...and ecg2
ecg2_filtered =filter(b, a, ecg2); 


% --------------------Comb filtering---------------------------%

% The sampling rate is 1000 Hz
FS = 1000;

% Load ECG 1 into Nx1 vector from the file ecg_signal_1.dat
ecg1 = load('ecg_signal_1.dat');

% Load ECG 2 into Nx1 vector from the file ecg_signal_2.dat
ecg2 = load('ecg_signal_2.dat');

% Create comb filter coefficients b and a
b = [0.6310, -0.2149, 0.1512, -0.1288, 0.1227, -0.1288, 0.1512, -0.2149, 0.6310];
a = 1;  % FIR filter, so a = 1

% Apply the filter to ecg1
ecg1_filtered = filter(b, a, ecg1);

% Apply the filter to ecg2
ecg2_filtered = filter(b, a, ecg2);

% Plot the original and filtered ECG signals

figure

% ECG 1 - Original and filtered (whole signal)
subplot(2,2,1)
plot((0:length(ecg1)-1)/FS, ecg1)
hold on
plot((0:length(ecg1_filtered)-1)/FS, ecg1_filtered)
ylabel('Amplitude [a.u.]')
xlabel('Time [s]')
title('ECG 1 - Original vs. Filtered')
legend('Original', 'Filtered');
xlim([0 length(ecg1)/FS]);

% ECG 2 - Original and filtered (whole signal)
subplot(2,2,2)
plot((0:length(ecg2)-1)/FS, ecg2)
hold on
plot((0:length(ecg2_filtered)-1)/FS, ecg2_filtered)
ylabel('Amplitude [a.u.]')
xlabel('Time [s]')
title('ECG 2 - Original vs. Filtered')
legend('Original', 'Filtered');
xlim([0 length(ecg2)/FS]);

% Frequency response of the comb filter
subplot(2,2,3:4)
freqz(b, a, [], FS);
title('Frequency Response of the Comb Filter');


% --------------------Cascaded filtering---------------------------%


% The sampling rate is 1000 Hz
FS = 1000;

% Load ECG 1 into Nx1 vector from the file ecg_signal_1.dat
ecg1 =load('ecg_signal_1.dat'); 

% Load ECG 2 into Nx1 vector from the file ecg_signal_2.dat
ecg2 =load('ecg_signal_2.dat'); 

% Create cascaded filter coefficients a and b using convolution
b1 =  1/10.*ones(1,10);
a1 =  1;
b2 = [1,-1];
a2 = [1,-0.995];
b2 = b2/max(freqz(b2,a2,[],FS));
b3 = [0.6310 -0.2149 0.1512 -0.1288 0.1227 -0.1288 0.1512 -0.2149 0.6310];
a3 = 1;
b = conv(conv(b1,b2),b3);
a = conv(conv(a1,a2),a3);
    
% Do the filtering using a, b, and ecg1
% For ecg1
ecg1_filtered =filter(b,a,ecg1); 
% ...and ecg2
ecg2_filtered =filter(b,a,ecg2); 