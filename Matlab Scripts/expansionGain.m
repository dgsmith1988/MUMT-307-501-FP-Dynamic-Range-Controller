%This is the gain function for a expander. x_dB is in the output value from
%the level detector in dBFS. T specifies the threshold value in dBFS. R 
%specifies the ratio (set to Inf for a gate). W is the knee width in dB,
%set it to 0 for a hard-knee. This function operates on a sample by sample
%basis (so don't pass it a vector).
function desired_gain = expansionGain(x_dB, T, R, W)
    if W ~= 0
        if x_dB < (T - W/2)
            desired_gain = T + (x_dB - T)*R;
        elseif ((T - W/2) <= x_dB) && (x_dB <= (T + W/2))
            desired_gain = x_dB + (1-R)*(x_dB - T - W/2)^2/(2*W);
        else
            desired_gain = x_dB;
        end
    else
        if x_dB < T
            desired_gain = T + (x_dB - T)*R;
        else
            desired_gain = x_dB;
        end
    end
end
