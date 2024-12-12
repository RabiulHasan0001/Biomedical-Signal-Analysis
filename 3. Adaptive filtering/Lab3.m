% --------------------Pan-Tompkins Algorithm for QRS Detection---------------------------%

% The sampling rate is 200 Hz 
FS = 200;

% Calculate the sample interval from FS
T = 1 / FS;

% Load the ECG from the file 'ECG.txt'
ECG = load('ECG.txt');

% Substract the first sample value to prevent P-T to amplify inital step
ECG = ECG - ECG(1)

% Lowpass filter The ECG
b_lowpass= (1/32) * [1 0 0 0 0 0 -2 0 0 0 0 0 1];
a_lowpass= [1 -2 1];
ECG_filtered1 = filter(b_lowpass, a_lowpass, ECG);

% Highpass filter the lowpass filtered ECG
b_highpass= (1/32)*[-1, zeros(1, 15), 32, -32, zeros(1, 14), 1]
a_highpass= [1 -1];
ECG_filtered2 = filter(b_highpass, a_highpass, ECG_filtered1);

% Differential filter the high- and lowpass filtered ECG
b_diff = (1/8)*[1, 2, 0, -2, -1];
a_diff = 1;
ECG_filtered3 = filter(b_diff, a_diff, ECG_filtered2);

% Square the derivative filtered signal
ECG_filtered4 = ECG_filtered3 .^ 2;

% Moving window integrator filter the squared signal
% Window size
N = 30;
b_integ = ones(1, N) / N;
a_integ = 1;
ECG_filtered5 = filter(b_integ, a_integ, ECG_filtered4);

% Set the blanking interval to 250 ms, but convert it to samples for the findQRS function
blankingInterval =  (250 * FS) / 1000;

% The amplitude threshold for QRS detection are set to these
treshold1 = 500; 
treshold2 = 2650; 

% Call the findQRS function 
[QRSStart_ECG, QRSEnd_ECG] = findQRS(ECG_filtered5,blankingInterval,treshold1,treshold2);

% Calculate the cumulative filter delays (in samples)
delays = 21;



subplot(6,1,1);
plot((1:length(ECG))*T,ECG);
xlabel('Time');
ylabel('A.U.');
title('Original');

subplot(6,1,2);
plot((1:length(ECG_filtered1))*T,ECG_filtered1);
xlabel('Time (s)');
ylabel('A.U.');
title('Lowpass_filtered');

subplot(6,1,3);
plot((1:length(ECG_filtered2))*T,ECG_filtered2);
xlabel('Time');
ylabel('A.U.');
title('Highpass_filtered');

subplot(6,1,4);
plot((1:length(ECG_filtered3))*T,ECG_filtered3);
xlabel('Time');
ylabel('A.U.');
title('Derivative_filtered');

subplot(6,1,5);
plot((1:length(ECG_filtered5))*T,ECG_filtered5);
xlabel('Time');
ylabel('A.U.');
title('Moving-window_integrator_output');


time_axis = (1:length(ECG))*T;
hold on; % Output of P-T
plot(time_axis(QRSStart_ECG),ECG_filtered5(QRSStart_ECG),'r*');
plot(time_axis(QRSEnd_ECG),ECG_filtered5(QRSEnd_ECG),'ro');

delays = round(delays); 
subplot(6,1,6);hold on; 
plot((1:length(ECG))*T,ECG);
plot(time_axis((QRSStart_ECG-delays)),ECG((QRSStart_ECG-delays)),'r*');
plot(time_axis((QRSEnd_ECG-delays)),ECG((QRSEnd_ECG-delays)),'ro');
xlabel('Time');
ylabel('A.U.');
title('Original_marked');

beats = length(QRSStart_ECG);
disp(['# beats: ', num2str(beats)]);
averageRRinterval = mean(QRSStart_ECG(2:length(QRSStart_ECG))-QRSStart_ECG(1:(length(QRSStart_ECG)-1)))*T*1000;
disp(['avg R-R: ', num2str(averageRRinterval)]);
stdRRinterval = std(QRSStart_ECG(2:length(QRSStart_ECG))-QRSStart_ECG(1:(length(QRSStart_ECG)-1)))*T*1000;
disp(['std R-R: ', num2str(stdRRinterval)]);
heartRate = 60*1000/averageRRinterval;
disp(['HR bpm : ', num2str(heartRate)]);
