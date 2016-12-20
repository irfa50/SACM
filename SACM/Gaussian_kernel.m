function u=Gaussian_kernel(x,s)
    u=(2*pi*s^2)^(-1/2)*exp(-x.^2/(2*s^2));
