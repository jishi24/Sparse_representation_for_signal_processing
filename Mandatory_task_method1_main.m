clc;
clear;
close all;

% input of data
X = load("PassiveOptical_Image.mat");
data1 = X.SN6_Train_AOI_11_Rotterdam_PAN_20190804113605_20190804113825_ti;
size(data1);
data=mat2gray(data1);

% add noise (gaussian) to image
noise_data = imnoise(data, 'gaussian', 0, 0.01);

% choose type of thresholding (hard or soft)
type = 's';

%the type of wavelet
wavelet_type={'haar','db1','db3','coif3','sym1'};


i=0;
for k=1:5
    
    i=i+1;
    %choose the type of wavelet  
    w_type=char(wavelet_type(k));
    
    % apply 2-level DWT2D (for 2D images)
    [cA1, cH1, cV1, cD1] = dwt2(noise_data, w_type); % level - 1
    [cA2, cH2, cV2, cD2] = dwt2(cA1, w_type); % level - 2
    
    %% LEVEL - 2
    % find threshold on detail components
    T_cH2 = adpt_thresh(cH1, 2, cH2);
    T_cV2 = adpt_thresh(cH1, 2, cV2);
    T_cD2 = adpt_thresh(cH1, 2, cD2);
    % apply threshold, these matrices are denoised before image reconstruction
    Y_cH2 = wthresh(cH2, type, T_cH2);
    Y_cV2 = wthresh(cV2, type, T_cV2);
    Y_cD2 = wthresh(cD2, type, T_cD2);

    %% LEVEL - 1
    % find threshold on detail components
    T_cH1 = adpt_thresh(cH1, 1, cH1);
    T_cV1 = adpt_thresh(cH1, 1, cV1);
    T_cD1 = adpt_thresh(cH1, 1, cD1);
    % apply threshold, these matrices are denoised before image reconstruction
    Y_cH1 = wthresh(cH1, type, T_cH1);
    Y_cV1 = wthresh(cV1, type, T_cV1);
    Y_cD1 = wthresh(cD1, type, T_cD1);


    % apply inverse discrete wavelet transform on all levels
    Y_cA1 = idwt2(cA2, Y_cH2, Y_cV2, Y_cD2, w_type);
    Y_cA = idwt2(Y_cA1, Y_cH1, Y_cV1, Y_cD1, w_type);
    denoised_data = Y_cA;

    %metrices evaluation
    data = 255*data;
    noise_data = 255*noise_data;
    denoised_data = 255*denoised_data;

    before_mse = immse(data,noise_data);
    after_mse = immse(data,denoised_data);
    
    fprintf('The mse value before denoising is %.2f.\n',before_mse);
    fprintf('The mse value after denoising by %s wavelet is %.2f.\n',w_type,after_mse);

    %plot original, noised and denoised image
    figure(i)
    subplot(3,1,1);
    imagesc(data);
    title('Original image')
    colormap(gray);

    subplot(3,1,2);
    imagesc(noise_data);
    title('Noise image')
    colormap(gray);

    subplot(3,1,3);
    imagesc(denoised_data)
    title([w_type '  image denoising'])
    colormap(gray);
    
    data = data/255.;
    noise_data = noise_data/255.;
end


    


