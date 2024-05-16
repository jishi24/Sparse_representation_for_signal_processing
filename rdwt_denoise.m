function [y_denoise, swc1, swc] = rdwt_denoise(y,wname,level,thr)

% This function is used to 1D signal denoising by the redundant discrete wavelet 
% transform.

% y: vector of data.
% swc: stationary wavelet decomposition.
% x_hat: vector of denoised data.
% wname: wavelet type.
% level: the number of wavelet decompositions
% thr: threshold value.

%% Decompose using RDWT.

swc= swt(y,level,wname);
swc1=swc;

%% Denoise.

% The length of input date.
len = length(y);

% Take the threshold value.
%thr=0.0005;


% Compute the correlation sequence.    
corr = swc(1,:).*swc(2,:).*swc(3,:).*swc(4,:);

% Compute the mask sequence.
m=zeros(1,len);
for i=1:len
    if abs(corr(i))>=thr
        m(i)=1;
    else
        m(i)=0;
    end
end  

% Denoise coefficients using mask.
swc(1,:)=swc(1,:).*m;
swc(2,:)=swc(2,:).*m;
swc(3,:)=swc(3,:).*m;
swc(4,:)=swc(4,:).*m;
%% Reconstruct the denoise signal using IRDWT.

y_denoise = iswt(swc,wname);
