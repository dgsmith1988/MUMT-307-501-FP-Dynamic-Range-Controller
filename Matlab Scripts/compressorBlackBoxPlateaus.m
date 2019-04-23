clear;
Fs = 48000;
Ts = 1/Fs;

%Peak detection parameters
attack_time = 0.250; %seconds
release_time = 0.10; %seconds

%Compression characteristics
T = -12;
R = 4;
W = 0;

%Attack and release imtes
alpha_a = exp(-log(9)/(Fs * attack_time));
alpha_r = exp(-log(9)/(Fs * release_time));

A1 = db2mag(0);
A2 = db2mag(T - .5);
A3 = db2mag(T - 1);
A4 = db2mag(T + .5 );
dur = .25;

x = [A2*ones(1, Fs*dur) A1*ones(1, Fs*dur) A3*ones(1, Fs*dur) A4*ones(1, Fs*dur) A3*ones(1, Fs*dur)];

y = compressorBlackBox(x, alpha_a, alpha_r, T, R, W);

t = (0:length(x)-1)*Ts;
figure;
plot(t, 20*log10(x), t, 20*log10(y));
yline(T, "--r");
legend("Input", "Output", "Threshold");
xlabel("Time (sec)");
ylabel("Level (dB)");
title(sprintf("Blackbox Rise and Timing Test: AT = %.3f sec, RT = %.3f sec", attack_time, release_time));
grid on;
grid minor;