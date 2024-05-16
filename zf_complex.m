function [c,s] = zf_complex(n)

c = zeros(1,n^2-1);
a = c;
b = c;

k = 1:(n-1);

c(k.^2) = 2*(n-(1:(n-1)))+1;

for ii=k
    m = 0:2*ii;
    l = ii^2 + m;
    a(l) = n-ii-1;
    b(l) = (ii-1)*n+1+m;
end

s = n^2 + a*n - b;

end