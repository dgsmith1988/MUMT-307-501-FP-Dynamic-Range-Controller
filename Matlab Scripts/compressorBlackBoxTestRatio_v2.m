clear;
Fs = 48000;
Ts = 1/Fs;

%Peak detection parameters
attack_time = 0.05; %seconds
release_time = 0.05; %seconds

%Compression characteristics
T = -65;
R = 2;
W = 0;

alpha_a = exp(-log(9)/(Fs * attack_time));
alpha_r = exp(-log(9)/(Fs * release_time));

%Generate the level sweep signal
x = db2mag(-144:.1:0);

y = compressorBlackBox(x, alpha_a, alpha_r, T, R, W);

t = (0:length(x)-1)*Ts;
figure;
plot(t, mag2db(x), t, mag2db(y));
yline(T, "--r");
legend("Input", "Output", "Threshold", "Location", "NorthWest");
xlabel("Time (sec)");
ylabel("Level (dBFS)");
title(sprintf("Blackbox Ratio Test, R = %3.2f", R));
grid on;
grid minor;