%This function performs the RMS approximation algorithm of
%y^2[n] = a*y^2[n-1] + (1-a)x^2[n], which has been shown to behave
%similarly the RMS algorithm but creates substantially much less delay. 
%The attack and release constants are calcuated in the manner described in
%the peak() function.
function y = RMS2(x, alpha_a, alpha_r) 
    persistent y_prev
    if isempty(y_prev)
        y_prev = 0;
    end
    
   %smooth the output to make the transitions more pleasing to the ear
    if abs(x) > y_prev
        %attack mode
        y = sqrt(alpha_a*y_prev^2 + (1-alpha_a)*abs(x)^2);
    else
        %release mode
        y = sqrt(alpha_r*y_prev^2 + (1-alpha_r)*abs(x)^2);
    end
    
    y_prev = y;
end