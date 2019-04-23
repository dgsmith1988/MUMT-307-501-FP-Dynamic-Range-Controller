clear;
Fs = 48000;
Ts = 1/Fs;
step_signal = [zeros(1, .5*Fs), ones(1, .5*Fs) ,zeros(1, 1*Fs)];

attack_time = .10; %seconds
release_time = .10; %seconds

%convert the attack and decay times to filter coefficients. these use the
%definition of rise time being the time it takes to go from 10% of a value
%to 90% of a value
alpha_a = exp(-log(9)./(Fs * attack_time));
alpha_r = exp(-log(9)./(Fs * release_time));

y_peak = zeros(1, length(step_signal));
y_rms2 = zeros(1, length(step_signal));
%do sample by sample processing as that's how things will eventually be
%done in the compressor
for n = 1:length(step_signal)
    y_peak(n) = peak(step_signal(n), alpha_a, alpha_r);
    y_rms2(n) = RMS2(step_signal(n), alpha_a, alpha_r);
end

t = (0:length(step_signal)-1)*Ts;
figure;
plot(t, y_peak, t, y_rms2, t, step_signal, 'k');
legend("Peak Method", "RMS Approximation", "Step Signal");
xlabel("Time (seconds)");
ylabel("Linear Amplitude");
title(sprintf('Step Response of "RMS Approximation" vs "Peak" for AT = %3.2f, RT = %3.2f seconds', attack_time, release_time));
grid on;
grid minor;