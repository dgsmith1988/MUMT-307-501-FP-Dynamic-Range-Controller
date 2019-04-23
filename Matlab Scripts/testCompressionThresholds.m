clear;
T = [-70 -60 -50 -40 -30 -20 -10 0];
R = 8;
W = 0;
dB_max = 0;
dB_min = -80;
x_dB = dB_min:.5:dB_max;
y_dB = zeros(1, length(x_dB));

figure;

hold on;
for i = 1: length(T)
    for n = 1:length(x_dB)
        y_dB(n) = compressionGain(x_dB(n), T(i), R, W);
    end
    plot(x_dB, y_dB)
end
hold off;

legend(compose("T = %i dBFS", T), 'Location', 'northwest')
title("Compression Gain Curves for Various Thresholds");
xlabel('Input Gain (dBFS)');
ylabel('Output Gain (dBFS)');
ylim([dB_min dB_max]);
xlim([dB_min dB_max]);
grid on; grid minor;