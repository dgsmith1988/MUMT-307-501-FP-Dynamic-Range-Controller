%Calculate the RMS of a signal on a sample by sample basis
function y_RMS = RMS(x)
    %Define the window length for RMS computation
    %I would put this in the function call but I want to make the amplitude
    %tracking algorithms all the same in order to keep things modular
    M = 1024;
    
    %Create a buffer to store computations in between the function calls
    persistent buffer
    if isempty(buffer)
        buffer = zeros(1, M);
    end
    
    %update the value and then perform the computations
    buffer = [buffer(2:end) x];
    
    y_RMS = sqrt(sum(abs(buffer).^2)/M);
end

