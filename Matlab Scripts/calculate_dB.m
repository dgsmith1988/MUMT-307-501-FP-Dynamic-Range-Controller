%This function takes a signal and converts it into dBFS value. It also eliminates
%any -Inf values by replacing them with the theoretical minimums based on
%the dynamic range for that bit-depth (assuming PCM w/ uniform quantization
%steps)
function y = calculate_dB(x, Q)
    y = 20*log10(x);
    limit = -floor(20*log10(2^Q));
    y(y < limit) = limit;
end