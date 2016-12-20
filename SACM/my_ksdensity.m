function f=my_ksdensity(x,xi,bandwidth)
f=0;
for k=1:length(x)
    f=f+Gaussian_kernel((x(k)-xi),bandwidth);
end
f=f/length(x);