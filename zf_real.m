function [c,s] = zf_real(n)

c = zeros(1,n*(n+1)/2-1);
a = c;
b = c;

k = 1:(n-1);

c(k.*(k+1)/2) = n+1-k;

for ii=k
    m = 0:ii;
    l = ii*(ii+1)/2 + m;
    a(l) = ii-1;
    b(l) = ii+1+m;
end

s = n^2 - a*n - b;

end
