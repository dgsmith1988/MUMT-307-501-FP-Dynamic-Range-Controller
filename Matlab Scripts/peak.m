%This function performs peak detection on signal (x) on a sample by sample
%basis and smooths it with a 1 pole filter based the attack and release
%constants. The constants should be calculated as follows
%
%alpha_a = exp(-log(9)/(Fs * attack_time));
%alpha_r = exp(-log(9)/(Fs * release_time));
function y = peak(x, alpha_a, alpha_r) 
    persistent y_prev
    if isempty(y_prev)
        y_prev = 0;
    end
    
    %smooth the output to make the transitions more pleasing to the ear
    if abs(x) > y_prev
        %attack mode
        y = alpha_a*y_prev + (1-alpha_a)*abs(x);
    else
        %release mode
        y = alpha_r*y_prev + (1-alpha_r)*abs(x);
    end
    
    y_prev = y;
end