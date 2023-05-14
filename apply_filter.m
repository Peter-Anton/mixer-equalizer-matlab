function reslt = apply_filter(filter_type,gains,audioData,samplerate)
freq1=[0 170 300 610 1005 3000 6000 12000 14000];
freq2=[170 300 610 1005 3000 6000 12000 14000 20000];
if (filter_type==0)
    order=600;
else
    order=8;
end

[a,b]=low_pass_filter(samplerate,freq1(1),order,filtertype);
x=filter(a,b,audioData);
reslt=x*gains(1);

for i=2:9
[a,b]=band_pass_filter(samplerate,freq1(i),freq2(i),order,filtertype);
x=filter(a,b,audioData);
reslt=audioData*gains(i);
end

end