function analyze_signal = analyze_signal(samplerate, filter_type, audidata)
    freq1 = [0 170 300 610 1005 3000 6000 12000 14000];
    freq2 = [170 300 610 1005 3000 6000 12000 14000 20000];
    num_samples = length(audidata);
    fs = samplerate;
    t = linspace(0, num_samples/samplerate, num_samples);
    f = linspace(-fs/2, fs/2, num_samples);
    
    if (filter_type == "FIR")
        order = 600;
    else
        order = 8;
    end
    
    [a, b] = low_pass_filter(samplerate, 170, order, filter_type);
    TF = tf(a, b);
    
    % Filter analysis
    figure();
    freqz(a, b, num_samples);
    title('Magnitude and phase of input frequency (0-170)');
    
    figure();
    subplot(3, 1, 1);
    pzmap(TF);
    title('Poles and zeros of low pass filtered signal (0-170)');
    
    
    subplot(3, 1, 2);
    impulse(TF);
    title('Impulse response of low pass filtered signal (0-170)');
    
    subplot(3, 1, 3);
    step(TF);
    title('Step response of low pass filtered signal (0-170)');
    
    % Output analysis
    y = filter(a, b, audidata);
    Y = fftshift(fft(y));
    
    figure();
    subplot(3, 1, 1);
    plot(t, y);
    title('Time domain of the output signal (0-170)');
    
    subplot(3, 1, 2);
    plot(f, abs(Y)); 
    title('Magnitude of the output signal (0-170)');
    
    subplot(3, 1, 3);
    plot(f, angle(Y));
    title('Phase of the output signal (0-170)');
    
    for i = 2:9
        [a, b] = band_pass_filter(samplerate, freq1(i), freq2(i), order, filter_type);
        TF = tf(a, b);
        
        % Filter analysis
        figure();
        freqz(a, b, num_samples);
        range = strcat(' (', int2str(freq1(i)), 'Hz - ', int2str(freq2(i)), 'Hz)');
        title(strcat('Magnitude & Phase of H', int2str(i), '(Z)', range));
        figure();
        subplot(3, 1, 1);
        pzmap(TF);
        title(strcat('Poles and zeros', int2str(i), '(Z)', range));
        
        subplot(3, 1, 2);
        impulse(TF);
        title(strcat('Impulse response', int2str(i), '(Z)', range));
        
        subplot(3, 1, 3);
        step(TF);
        title(strcat('Step response', int2str(i), '(Z)', range));
        
        % Output analysis
        y = filter(a, b, audidata);
        Y = fftshift(fft(y));
        
        figure();
        subplot(3, 1, 1);
        plot(t, y);
        title(strcat('Time domain of the output signal', int2str(i), '(Z)', range));
        
        subplot(3, 1, 2);
        plot(f, abs(Y)); 
        title(strcat('Magnitude of the output signal', int2str(i), '(Z)', range));
        
        subplot(3, 1, 3);
        plot(f, angle(Y));
        title(strcat('Phase of the output signal', int2str(i), '(Z)', range));
    end
end
