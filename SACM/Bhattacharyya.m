function phi = Bhattacharyya(I,phi_0,lambda,delta_t,epsilon,bandwidth,numIter)
phi=phi_0;
for k=1:numIter
    phi=NeumannBoundCond(phi);
    delta_h=(epsilon/pi)./(epsilon^2+ phi.^2);
    %delta_h=ones(size(phi));
    %delta_h(abs(delta_h)<=epsilon)=1./(2*epsilon).*(1+cos(pi.*phi/epsilon));
    Curv = curvature(phi); %¼ÆËãphiµÄÇúÂÊ Curv
    if k==1
        p_plus = ksdensity(I(phi>0),0:255,'width',bandwidth);
        p_minus = ksdensity(I(phi<0),0:255,'width',bandwidth);
    else
        p_plus = (p_plus*R_plus+sum(sum(xor(phi>0,phi_old>0))).*ksdensity(I(xor(phi>0,phi_old>0)),0:255,'width',bandwidth))./sum(sum(phi>0));
        p_minus = (p_minus*R_minus-sum(sum(xor(phi<0,phi_old<0)))*ksdensity(Img(xor(phi<0,phi_old<0)),0:255,'width',bandwidth))/sum(sum(phi<0));
    end
    R_plus=sum(sum(phi>0));
    R_minus=sum(sum(phi<0));
%     figure(2);
    subplot(122);

    plot(0:255,p_plus,'r');
    hold on;
    plot(0:255,p_minus,'g')
    hold off;
    V=0;
    for z=0:255
        s1=sqrt(p_minus(z+1)*p_plus(z+1))*(1/R_minus-1/R_plus);
        s2=Gaussian_kernel((z-I),bandwidth)*sqrt(p_minus(z+1)/(p_plus(z+1)+1e-10))*(1/R_plus);
        s3=Gaussian_kernel((z-I),bandwidth)*sqrt(p_plus(z+1)/(p_minus(z+1)+1e-10))*(1/R_minus);
        V=V+0.5*(s1+s2-s3);
    end 
    phi=phi+delta_t*delta_h.*(lambda*Curv-3000*V);
    phi_old=phi;
end

function g = NeumannBoundCond(f)
% Neumann boundary condition
[nrow,ncol] = size(f);
g = f;
g([1 nrow],[1 ncol]) = g([3 nrow-2],[3 ncol-2]);  
g([1 nrow],2:end-1) = g([3 nrow-2],2:end-1);          
g(2:end-1,[1 ncol]) = g(2:end-1,[3 ncol-2]);  
