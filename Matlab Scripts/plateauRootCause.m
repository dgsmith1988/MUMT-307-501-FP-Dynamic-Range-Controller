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

%We have to break open the "black-box" in this case to get to the
%root-casue
clear peak;
x_peak = zeros(1, length(x));
x_dB = zeros(1, length(x));
g_sc = zeros(1, length(x));
g_change = zeros(1, length(x));
y = zeros(1, length(x));
for n = 1:length(x)
    x_peak(n) = peak(x(n), alpha_a, alpha_r);
    x_dB(n) = calculate_dB(x_peak(n), 32);
    g_sc(n) = compressionGain(x_dB(n), T, R, W);
    g_change(n) = g_sc(n) - x_dB(n);
    y(n) = db2mag(g_change(n))*x(n);
end

t = (0:length(x)-1)*1/Fs;
figure; 
plot(t, x_peak, t, x); 
grid on; grid minor;
yline(db2mag(T), "--r");
legend("Peak Detector Output", "Step Signal Input", "Threshold");
xlabel("Time (sec)");
ylabel("Level (Linear)");
title("Plateau Root Cause Analysis");