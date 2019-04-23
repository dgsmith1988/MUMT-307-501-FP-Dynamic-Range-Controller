clear;
Fs = 48000;
Ts = 1/Fs;

%Peak detection parameters
attack_time = 0.0; %seconds
release_time = 0.0; %seconds

%Compression characteristics
T = -50;
R = 2;
W = 4;

alpha_a = exp(-log(9)/(Fs * attack_time));
alpha_r = exp(-log(9)/(Fs * release_time));

dur = .25;
%amp_envelope = [A2*ones(1, Fs*dur) A1*ones(1, Fs*dur) A3*ones(1, Fs*dur)];

f = 440;
%n = 0:length(amp_envelope) - 1;
%x = amp_envelope.*sin(2*pi*n*Ts*f);
%x = [A2*ones(1, Fs*dur) A1*ones(1, Fs*dur) A3*ones(1, Fs*dur) A4*ones(1, Fs*dur) A3*ones(1, Fs*dur)];
x = db2mag(-144:.1:0);

y = compressorBlackBox(x, alpha_a, alpha_r, T, R, W);

t = (0:length(x)-1)*Ts;
figure;
plot(t, mag2db(x), t, mag2db(y));
%plot(t, x, t, y);
yline(T, "--r");
yline(T-W/2, "--b");
yline(T+W/2, "--b");

%yline(db2mag(T), "--r");
legend("Input", "Output", "Threshold", "Knee Boundaries", "Location", "NorthWest");
xlabel("Time (sec)");
ylabel("Level (dBFS)");
title(sprintf("Blackbox Knee Test w/ Ratio = %3.2f ", R));
grid on;
grid minor;