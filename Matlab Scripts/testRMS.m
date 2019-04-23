clear;
clear RMS;
Fs = 48000;
Ts = 1/Fs;
step_signal = [zeros(1, .5*Fs), ones(1, .5*Fs) ,zeros(1, .5*Fs)];

M = 1024;

buffer = zeros(1, M);

y_me = zeros(1, length(step_signal));
y_matlab = y_me; 
for n = 1:length(step_signal)
    y_me(n) = RMS(step_signal(n));
    buffer = [buffer(2:end) step_signal(n)];
    y_matlab(n) = rms(buffer);
end

plot(y_me);
hold on;
plot(y_matlab);
hold off;