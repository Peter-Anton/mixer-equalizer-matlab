function [a,b] = low_pass_filter(samplerate, cutoffFreq, order, filter)
    fm = samplerate / 2;
    wn = cutoffFreq / fm;
  
    if (filter == "FIR")
        [a, b] = fir1(order, wn, 'low');
        [a, b] = eqtflength(a, b);
    else
        [a, b] = butter(order, wn);
        [a, b] = eqtflength(a, b);
    end
end