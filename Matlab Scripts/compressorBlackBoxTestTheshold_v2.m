clear;
Fs = 48000;
Ts = 1/Fs;

%Peak detection parameters
attack_time = 0.00; %seconds
release_time = 0.00; %seconds

%Compression characteristics
T = -65;
R = 4;
W = 0;

alpha_a = exp(-log(9)/(Fs * attack_time));
alpha_r = exp(-log(9)/(Fs * release_time));

%generate the level sweep
x = db2mag(-144:.1:0);

y = compressorBlackBox(x, alpha_a, alpha_r, T, R, W);

t = (0:length(x)-1)*Ts;
figure;
plot(t, mag2db(x), t, mag2db(y));
yline(T, "--r");
legend("Input", "Output", "Threshold", "Location", "NorthWest");
xlabel("Time (sec)");
ylabel("Level (dBFS)");
title("Compressor Blackbox Threshold Test w/ No Attack Time" );
grid on;
grid minor;