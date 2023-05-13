 y=audioread('sample_mono.wav');
 y=resample(y,10000,22050);
 y=y(1:20000);
 Y=fftshift(fft(y));
 Y([6001:8000 12001:14000])=0;
 y2=real(ifft(Y));
 sound(y2,10000);