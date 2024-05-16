function [T] = adpt_thresh(M, level,test_matrix)
% CODE FOR adpt_thresh() method
%function for finding sigma and threshold
%input: the matrix for which you want to find the threshold
%output : the threshold value 'T'.
%[a,b] = size(M);
%M is only HH band
%var_test is the variance of test_matrix
C = 0.6745;
var_noise = (median(abs(M(:)))/C)^2;
L=length(test_matrix(:));


beta = sqrt(log(length(test_matrix)/level));
var_test = var(test_matrix(:))*(L-1)/L;
sigma_x =sqrt(max((var_test-var_noise),0));



T = beta*var_noise/sigma_x;

end