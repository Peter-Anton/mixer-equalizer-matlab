function [a,b]=low_pass_filter(samplerate,cutoffFreq,order,filter_type)
fm=samplerate/2;
wn=cutoffFreq/fm;
if (filter_type==0)
    [a,b]=fir1(order,wn,'low');
else
    [a,b]=butter(order,wn);
end

end