function result = apply_filter(filter_type, gains, audio_data, sample_rate)
    % Define frequency ranges for each band
    disp(filter_type)
    freq1 = [0, 170, 300, 610, 1005, 3000, 6000, 12000, 14000];
    freq2 = [170, 300, 610, 1005, 3000, 6000, 12000, 14000, 20000];
    filter_order=0;
    
    % Set filter order based on filter type
    if filter_type == "FIR"
        filter_order = 600;
    elseif filter_type== "IIR"
        filter_order = 4;
    end

    % Apply low-pass filter to the audio data for the first band
    [a, b] = low_pass_filter(sample_rate, 170, filter_order, filter_type);
    filtered_data = filter(a, b, audio_data);
    result = filtered_data * gains(1);

    % Apply band-pass filters to the audio data for the remaining bands
    for i = 2:9
        [a, b] = band_pass_filter(sample_rate, freq1(i), freq2(i), filter_order, filter_type);
        filtered_data = filter(a, b, audio_data);
        result = result + filtered_data * gains(i);
    end
end

% Apply different filters to the audio data based on filter type and frequency range
% Multiply each filtered result with the corresponding gain value

% The function takes the following inputs:
% - filter_type: a string specifying the type of filter ("FIR" or "IIR")
% - gains: a vector of gain values for each frequency band
% - audio_data: the input audio data
% - sample_rate: the sample rate of the audio data

% The function returns the filtered and scaled audio data as the output result.