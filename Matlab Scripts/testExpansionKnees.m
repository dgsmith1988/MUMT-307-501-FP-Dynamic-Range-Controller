clear;
T = -30;
R = 4;
W = [0 4 8 12 16];
dB_max = 0;
dB_min = -80;
x_dB = dB_min:.5:dB_max;
y_dB = zeros(1, length(x_dB));

figure;

hold on;
for i = 1: length(W)
    for n = 1:length(x_dB)
        y_dB(n) = expansionGain(x_dB(n), T, R, W(i));
    end
    plot(x_dB, y_dB)
end
hold off;

title(sprintf("Expansion Curves for Various Knee Widths @ T = %i dBFS", T));
xlabel('Input Gain (dBFS)');
ylabel('Output Gain (dBFS)');
xline(T, "--r");
ylim([(T-(max(W)/2)*R) (T+max(W)/2)]);
xlim([(T-max(W)/2) (T+max(W)/2)]);
legend([compose("W = %i dB", W), 'Threshold'], 'Location', 'northwest')

grid on; grid minor;