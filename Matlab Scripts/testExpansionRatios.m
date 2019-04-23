clear;
T = -20;
%Unfortunately setting to R = Inf results in nothing appearing on the
%graph so the "gating" functionality was verifed by manual inspection of
%the vector 
%R = [.25 .5 1 2 4 8 16 Inf]; %Use this one for testing purposes
R = [.25 .5 1 2 4 8 16]; %Use this one for plotting purposes
W = 0;
dB_max = 0;
dB_min = -80;
x_dB = dB_min:.5:dB_max;
y_dB = zeros(1, length(x_dB));

figure;

hold on;
for i = 1: length(R)
    for n = 1:length(x_dB)
        y_dB(n) = expansionGain(x_dB(n), T, R(i), W);
    end
    plot(x_dB, y_dB)
end
hold off;

legend(compose("R = %3.2f ", R), 'Location', 'northwest')
title("Expansion Gain Curves for Various Ratios");
xlabel('Input Gain (dBFS)');
ylabel('Output Gain (dBFS)');
ylim([dB_min dB_max]);
xlim([dB_min dB_max]);
grid on; grid minor;