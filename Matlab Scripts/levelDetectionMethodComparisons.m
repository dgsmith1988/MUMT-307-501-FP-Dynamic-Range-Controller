clear;

%clear all the things with persisted variables
clear RMS;
clear RMS2;
clear peak;

Fs = 48000;
Ts = 1/Fs;
step_signal = [zeros(1, .5*Fs), ones(1, .5*Fs) ,zeros(1, 1*Fs)];

attack_time = 0.25; %seconds
release_time = attack_time; %seconds

alpha_a = exp(-log(9)/(Fs * attack_time));
alpha_r = exp(-log(9)/(Fs * release_time));

y_peak = zeros(1, length(step_signal));
y_rms = zeros(1, length(step_signal));
y_rms2 = zeros(1, length(step_signal));
for n = 1:length(step_signal)
    y_peak(n) = peak(step_signal(n), alpha_a, alpha_r);
    y_rms(n) = RMS(step_signal(n));
    y_rms2(n) = RMS2(step_signal(n), alpha_a, alpha_r);
end

t = (0:length(step_signal)-1)*Ts;
figure;
plot(t, step_signal, t, y_peak, t, y_rms, t, y_rms2);
legend('Step Signal', 'Y-peak', 'Y-RMS', 'Y-RMS2');
title(sprintf("Level Detection Step Responses for AT and RT set to %3.2f seconds", attack_time));
xlabel("Time (sec)");
ylabel("Linear Amplitude");
grid on;
grid minor;