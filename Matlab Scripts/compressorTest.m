clear;
%clear all the things with persisted variables
clear peak;
Fs = 48000;
Ts = 1/Fs;

%Peak detection parameters
attack_time = 0.10; %seconds
release_time = 0.10; %seconds

%Compression characteristics
T = -12;
R = 4;
W = 4;

%Make the following variables global so you don't ahve to recalculate them
%in the functions
alpha_a = exp(-log(9)/(Fs * attack_time));
alpha_r = exp(-log(9)/(Fs * release_time));

%fullscale signal to test the compressor response...
%this can be adjustable later...
A1 = db2mag(0);
A2 = db2mag(T - .5);
A3 = db2mag(T - 1);
dur = .5;
amp_envelope = [A2*ones(1, Fs*dur) A1*ones(1, Fs*dur) A3*ones(1, Fs*dur)];

f = 440;
%n = 0:length(amp_envelope) - 1;
%x = amp_envelope.*sin(2*pi*n*Ts*f);
x = [A2*ones(1, Fs*dur) A1*ones(1, Fs*dur) A3*ones(1, Fs*dur)];

%preallocate vectors for things used in loop calculation
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
t = (0:length(x)-1)*Ts;
figure;
plot(t, x, t, y);