function phi = EVOLUTION_CV(I, phi0, mu, nu, lambda_1, lambda_2, delta_t, epsilon, numIter);
phi=phi0;
for k=1:numIter
    phi=NeumannBoundCond(phi);
    delta_h=(epsilon/pi)./(epsilon^2+ phi.^2);
    Curv = curvature(phi); %¼ÆËãphiµÄÇúÂÊ Curv
    
    %[C1,C2]=binaryfit(phi,I,epsilon);
    H = 0.5*(1+ (2/pi)*atan(phi./epsilon));
    a= H.*I;
    numer_1=sum(a(:)); 
    denom_1=sum(H(:));
    C1 = numer_1/denom_1;

    b=(1-H).*I;
    numer_2=sum(b(:));
    c=1-H;
    denom_2=sum(c(:));
    C2 = numer_2/denom_2;

    
    
    % updating the phi function
    %phi=phi+delta_t*delta_h.*(mu*Curv-nu-lambda_1*(I-C1).^2+lambda_2*(I-C2).^2);
    phi=phi+delta_t*delta_h.*(mu*Curv);
end



function g = NeumannBoundCond(f)
% Make a function satisfy Neumann boundary condition
[nrow,ncol] = size(f);
g = f;
g([1 nrow],[1 ncol]) = g([3 nrow-2],[3 ncol-2]);  
g([1 nrow],2:end-1) = g([3 nrow-2],2:end-1);          
g(2:end-1,[1 ncol]) = g(2:end-1,[3 ncol-2]);  