%This is a full-compressor implemenation simulating a "black-box". x is the
%input vector, alpha_a and alpha_r are the attack and release times
%respectively. The rest of the parameters are the same as described in the
%compressorGain() function
function y = compressorBlackBox(x, alpha_a, alpha_r, T, R, W)
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
    %figure;
    %n = 1:length(x);
    %Fs = 48000;
    %t = (0:length(x)-1)*1/Fs;
    %plot(t, x_peak, '--', t, x_dB, ":", t, g_sc, '-.',  t, g_change, '.');
    %title('Compressor Interal Debugging');
    %legend('x peak', 'x dB', 'g sc', 'g change');
    %grid on; grid minor;
    %figure; plot(t, x_peak, t, x); grid on; grid minor;
    %figure; plot(t, x_dB); grid on; grid minor;
    %yline(T, "--r");
end