function phi = AMP(I,phi_0,lambda,delta_t,epsilon,bandwidth,numIter)
phi=phi_0;
for k=1:numIter
    phi=NeumannBoundCond(phi);
    delta_h=(epsilon/pi)./(epsilon^2+ phi.^2);
    %delta_h=ones(size(phi));
    %delta_h(abs(delta_h)<=epsilon)=1./(2*epsilon).*(1+cos(pi.*phi/epsilon));
    Curv = curvature(phi); %¼ÆËãphiµÄÇúÂÊ Curv
 
    p_plus = ksdensity(I(phi>0),0:255,'width',bandwidth);
    p_minus = ksdensity(I(phi<0),0:255,'width',bandwidth);
    R_plus=sum(sum(phi>0));
    R_minus=sum(sum(phi<0));
    subplot(122);
    plot(0:255,p_plus,'r',0:255,p_minus,'g');
    legend('out','int');
    
    V=0;
    for z=0:255
        s1=p_minus(z+1)*p_plus(z+1)*(p_minus(z+1)/R_minus-p_plus(z+1)/R_plus)/(p_minus(z+1)+p_plus(z+1)+1e-10)^2;
        s2=Gaussian_kernel((z-I),bandwidth)*(p_minus(z+1)^2/R_plus-p_plus(z+1)^2/R_minus)/(p_minus(z+1)+p_plus(z+1)+1e-10)^2;
        V=V+0.5*(s1+s2);
    end 
    phi=phi+delta_t*delta_h.*(lambda*Curv-3000*V);
end

function g = NeumannBoundCond(f)
% Neumann boundary condition
[nrow,ncol] = size(f);
g = f;
g([1 nrow],[1 ncol]) = g([3 nrow-2],[3 ncol-2]);  
g([1 nrow],2:end-1) = g([3 nrow-2],2:end-1);          
g(2:end-1,[1 ncol]) = g(2:end-1,[3 ncol-2]);  


