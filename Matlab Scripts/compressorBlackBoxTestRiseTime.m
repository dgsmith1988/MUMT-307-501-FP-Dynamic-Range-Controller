clear;
Fs = 48000;
Ts = 1/Fs;

%Peak detection parameters
attack_time = 0.10; %seconds
release_time = 0.10; %seconds

%Compression characteristics
T = -12;
R = 4;
W = 0;

alpha_a = exp(-log(9)/(Fs * attack_time));
alpha_r = exp(-log(9)/(Fs * release_time));

%fullscale signal to test the compressor response...
%this can be adjustable later...
A1 = db2mag(-4);
A2 = db2mag(T - .5);
A3 = db2mag(T - 1);
A4 = db2mag(T + .5 );
dur = .5;
%amp_envelope = [A2*ones(1, Fs*dur) A1*ones(1, Fs*dur) A3*ones(1, Fs*dur)];

f = 440;
%n = 0:length(amp_envelope) - 1;
%x = amp_envelope.*sin(2*pi*n*Ts*f);
x = [A2*ones(1, Fs*dur) A1*ones(1, Fs*dur) A3*ones(1, Fs*dur) A4*ones(1, Fs*dur) A3*ones(1, Fs*dur)];

y = compressorBlackBox(x, alpha_a, alpha_r, T, R, W);

t = (0:length(x)-1)*Ts;
figure;
plot(t, 20*log10(x), t, 20*log10(y));
%plot(t, x, t, y);
yline(T, "--r");
%yline(db2mag(T), "--r");
legend("Input", "Output", "Threshold");
xlabel("Time (sec)");
ylabel("Level (dB)");
title("Blackbox Threshold Test" );
grid on;
grid minor;