%input data
data2 = imread("s1_channel2.tif");
imshow(data2);
data2=mat2gray(data2);

% choose type of thresholding (hard or soft)
type = 's';


% apply 2-level DWT2D (for 2D images)
[cA1, cH1, cV1, cD1] = dwt2(data2, 'coif3'); % level - 1
[cA2, cH2, cV2, cD2] = dwt2(cA1, 'coif3'); % level - 2




%% LEVEL - 2

% the threshold value for the wavelet coefficients of LL_2
thr3 = 0.54;

% amplify high frequency coefficients and suppress low frequency coefficients
cA2(abs(cA2)<thr3) = cA2(abs(cA2)<thr3)*2.;
cA2(abs(cA2)>=thr3) = cA2(abs(cA2)>=thr3)/2.;

% the threshold value for the wavelet coefficients of LH_2, HL_2, HH_2
thr2 = 0.1;

% amplify high frequency coefficients and suppress low frequency coefficients
cH2(abs(cH2)<thr2) = cH2(abs(cH2)<thr2)*2;
cH2(abs(cH2)>=thr2) = cH2(abs(cH2)>=thr2)/2.;

cV2(abs(cV2)<thr2) = cV2(abs(cV2)<thr2)*2;
cV2(abs(cV2)>=thr2) = cV2(abs(cV2)>=thr2)/2.;

cD2(abs(cD2)<thr2) = cD2(abs(cD2)<thr2)*2;
cD2(abs(cD2)>=thr2) = cD2(abs(cD2)>=thr2)/2.;

Y_cH2 = cH2;
Y_cV2 = cV2;
Y_cD2 = cD2;

%% LEVEL - 1

% the threshold value for the wavelet coefficients of LH_1, HL_1, HH_1
thr1 = 0.05;

% amplify high frequency coefficients and suppress low frequency coefficients
cH1(abs(cH1)<thr1) = cH1(abs(cH1)<thr1)*2;
cH1(abs(cH1)>=thr1) = cH1(abs(cH1)>=thr1)/2.;

cV1(abs(cV1)<thr1) = cV1(abs(cV1)<thr1)*2;
cV1(abs(cV1)>=thr1) = cV1(abs(cV1)>=thr1)/2.;

cD1(abs(cD1)<thr1) = cD1(abs(cD1)<thr1)*2;
cD1(abs(cD1)>=thr1) = cD1(abs(cD1)>=thr1)/2.;

Y_cH1 = cH1;
Y_cV1 = cV1;
Y_cD1 = cD1;


%% wavelet reconstruction

% apply inverse discrete wavelet transform on all levels
Y_cA1 = idwt2(cA2, Y_cH2, Y_cV2, Y_cD2, 'coif3');
Y_cA = idwt2(Y_cA1, Y_cH1, Y_cV1, Y_cD1, 'coif3');
data2_sharpen = Y_cA;




%plot original and sharpened image
subplot(2,1,1);
imagesc(data2);
title('Original image')
colormap(gray);



subplot(2,1,2);
imagesc(data2_sharpen)
title('Sharpened image')
colormap(gray);


