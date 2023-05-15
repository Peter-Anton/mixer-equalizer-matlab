function analyze_signal=analyze_signal(samplerate,filter_type,audidata)
    freq1=[0 170 300 610 1005 3000 6000 12000 14000];
    freq2=[170 300 610 1005 3000 6000 12000 14000 20000];
    num_sample=length(audidata);
    fs=samplerate;
    t=linsapce(0,num_sample/samplerate,num_sample);
    f=linsapce(-fs/2,fs/2,num_sample)
    order=0;
    if (filter_type==0)
    order=600;
    else
    order=8;
end
[a,b]=low_pass_filter(samplerate,170,order,filter_type);
TF=tf(a,b);
%filter_anlysize
figure();
subplot(2,1,1);
freqz(a,b,num_sample);
title('magnitude and ohase of input freq(0-170)');
subplot(2,1,2);
pzmap(tf);
title('poles and zeros of low pass filtered signal (0-170)');
figure();
subplot(2,1,1);
impulse(TF);
title('impulse response of low pass filtered signal (0-170)');
subplot(2,1,2);
step(TF);
title('step response of low pass filtered signal (0-170)');
%output_analsyze
y=filter(a,b,audidata);
Y=fftshift(fft(y));
figure();
subplot(3,1,1);
plot(t,y);
title('time domain of the output signal (0-170)');
subplot(3,1,2);
plot(f,abs(Y)); 
title('magnitude of the output signal (0-170)');
subplot(3,1,3);
plot(f,angle(Y));
title('phase of the output signal (0-170)');
for i=2:9
[a,b]=bandpass(samplerate,freq1(i),freq2(i),order,filter_type);
TF=tf(a,b);
%filter_anlysize
figure();
subplot(2,1,1);
freqz(a,b,num_sample);
   range = strcat(' (',int2str(freq1(i)),'Hz - ',int2str(freq2(i)),'Hz)');
    title(strcat('Magnitude & Phase of H',int2str(i),'(Z)',range));
title('magnitude and phase of ');
subplot(2,1,2);
pzmap(tf);
title('poles and zeros',int2str(i),'(Z)',range);
figure();
subplot(2,1,1);
impulse(TF);
title('impulse response',int2str(i),'(Z)',range);
subplot(2,1,2);
step(TF);
title('step response',int2str(i),'(Z)',range);
%output_analsyze
y=filter(a,b,audidata);
Y=fftshift(fft(y));
figure();
subplot(3,1,1);
plot(t,y);
title('time domain of the output signal',int2str(i),'(Z)',range);
subplot(3,1,2);
plot(f,abs(Y)); 
title('magnitude of the output signal',int2str(i),'(Z)',range);
subplot(3,1,3);
plot(f,angle(Y));
title('phase of the output signa',int2str(i),'(Z)',range);
end
end