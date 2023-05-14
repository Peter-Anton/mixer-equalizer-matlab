function [a,b]=band_pass_filter(samplerate,cutoffFreq1,cutoffFreq2,order,filter_type)
fm=samplerate/2;
wn=[cutoffFreq1 cutoffFreq2]/fm;
if (filter_type==0)
    [a,b]=fir1(order,wn,'bandpass');
else
    [a,b]=butter(order,wn,'bandpass');
end

end