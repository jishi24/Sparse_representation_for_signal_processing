clc;
clear;
close all;

%% Input data.

load original_signal.dat;
load noisy_signal.dat;
x=original_signal(1,:);
y=noisy_signal(1,:);

%% Analysis parameters.

% Wavelet type.
wname = 'db2';

% The number of wavelet decompositions.
level = 9;

% Threshold value.
thr=0.00042;



%% Denoise.

% Using the function 'rdwt_denoise' to denoise the noisy signal.
[y_denoise,swc1,swc]=rdwt_denoise(y,wname,level,thr);

%% Metrices evaluation.

% Compute the value of MSE. 
before_mse = immse(x,y);
after_mse = immse(x,y_denoise);

%% Output.

%Plot original signal.
figure(1);
plot(x);
title('original signal');

%Plot noisy signal.
figure(2);
plot(y);
title('Noisy signal');

%Plot noisy signal.
figure(3)
plot(y_denoise);
title('Denoised signal');

% Plot the figure of detail coefficients at different levels 
% and plot the figure of and approximation coefficients at last level
% before denoising.

figure(4)

for k=1:(level+1)

    if k<level+1;
   
       subplot(5,2,k);
       plot(swc1(k,:));
       title(['Detail coefficients at level ',num2str(k)],...
           'Interpreter', 'latex');
    else
        subplot(5,2,k);
        plot(swc1(k,:));
        title(['Approximation coefficients at level ',num2str(k)],...
           'Interpreter', 'latex');
    end
end


% Plot the figure of detail coefficients at different levels 
% and plot the figure of and approximation coefficients at last level
% after denoising.

figure(5)
for k=1:(level+1)

    if k<level+1;
   
       subplot(5,2,k);
       plot(swc(k,:));
       title(['Detail coefficients at level ',num2str(k)],...
           'Interpreter', 'latex');
    else
        subplot(5,2,k);
        plot(swc1(k,:));
        title(['Approximation coefficients at level ',num2str(k)],...
           'Interpreter', 'latex');
    end
end


% Output mse value.
fprintf('The mse value before denoising is %.5f.\n',before_mse);
fprintf('The mse value after denoising is %.5f.\n',after_mse);