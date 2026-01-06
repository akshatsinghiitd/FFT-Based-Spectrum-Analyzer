clc;        % Command Window clear
clear;      % Workspace clear
close all;  % All figures close

%Step1

% Signal parameters
f = 5;          % Signal frequency (Hz)
Fs = 100;       % Sampling frequency (Hz)
T = 1;          % Signal duration (seconds)

% Time vector
t = 0:1/Fs:T-1/Fs; %Start with 0 takes step of 1/Fs and total time is 1 sec
                   %t = [0, step, 2*step, 3*step, ..., end]

% Generate sampled signal
x = sin(2*pi*f*t); % x is dts

%Time domain plot
figure;
plot(t, x);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Time-Domain Signal');
grid on;

%In Step-1, the continuous-time sinusoidal signal is sampled to obtain the discrete-time signal x[n] 

% STEP-2 : FFT BASED FREQUENCY DOMAIN ANALYSIS

% FFT length (number of samples)
N = length(x);              % Total number of discrete samples

% Apply FFT to the discrete-time signal x(n)
X = fft(x, N);              % FFT output (complex frequency bins)

% Magnitude spectrum (absolute value of FFT output)
X_mag = abs(X);             % |X(k)| gives strength of each frequency component

% Create frequency axis in Hz
f_axis = (0:N-1)*(Fs/N);    % Frequency corresponding to each FFT bin

% Take single-sided spectrum (0 to Fs/2)
half_N = floor(N/2);        % Half length for single-sided spectrum
f_axis_half = f_axis(1:half_N);
X_mag_half = X_mag(1:half_N);

% Plot frequency-domain spectrum
figure;
plot(f_axis_half, X_mag_half, 'r', 'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('FFT-Based Frequency Spectrum');
grid on;


%% STEP-3 : Add Noise to the Signal

noise_amp = 0.5;                 % Noise strength (adjust karke dekho)
noise = noise_amp * randn(size(x));  % White Gaussian noise

x_noisy = x + noise;             % Noisy signal

figure;
plot(t, x_noisy);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Noisy Time-Domain Signal');
grid on;

% FFT of noisy signal
Xn = fft(x_noisy, N);

% Magnitude spectrum
Xn_mag = abs(Xn);

% Single-sided spectrum
Xn_mag_half = Xn_mag(1:half_N);

figure;
plot(f_axis_half, Xn_mag_half, 'm', 'LineWidth', 1.2);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('FFT Spectrum of Noisy Signal');
grid on;



% STEP-4 : Apply Windowing (Hamming Window)

w = hamming(N);          % Hamming window (length N)
x_win = x_noisy .* w.';  % Windowed signal (transpose important)

% FFT of windowed signal
Xw = fft(x_win, N);

% Magnitude spectrum
Xw_mag = abs(Xw);

% Single-sided spectrum
Xw_mag_half = Xw_mag(1:half_N);

figure;
plot(f_axis_half, Xn_mag_half, 'r--', 'LineWidth', 1); hold on;
plot(f_axis_half, Xw_mag_half, 'b',  'LineWidth', 1.5);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Spectrum Comparison: Without Window vs With Hamming Window');
legend('Without Window', 'With Hamming Window');
grid on;





