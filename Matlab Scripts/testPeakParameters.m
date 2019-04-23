clear;
Fs = 48000;
Ts = 1/Fs;
duration = 1; %1 second
step_signal = [zeros(1, .5*Fs), ones(1, .75*Fs) ,zeros(1, 1.25*Fs)];

attack_time = [.01 .1 0.25 .5]; %seconds
release_time = fliplr(attack_time); %seconds

%convert the attack and decay times to filter coefficients. these use the
%definition of rise time being the time it takes to go from 10% of a value
%to 90% of a value
alpha_a = exp(-log(9)./(Fs * attack_time));
alpha_r = exp(-log(9)./(Fs * release_time));

y_peak = zeros(1, length(step_signal));
t = (0:length(step_signal)-1)*Ts;
figure;
hold on;
%do sample by sample processing as that's how things will eventually be
%done in the compressor
for i = 1:length(attack_time)
    clear peak;
    for n = 1:length(step_signal)
        y_peak(n) = peak(step_signal(n), alpha_a(i), alpha_r(i));
    end
    plot(t, y_peak);
end

plot(t, step_signal, 'k');
hold off;
legend([compose("AT = %3.2f, RT = %3.2f (sec)", [attack_time; release_time]')', "Step Signal"]);
xlabel("Time (seconds)");
ylabel("Linear Amplitude");
title('Step Response of "Peak Detector" for Various Time Constants');
grid on;
grid minor;