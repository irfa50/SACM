function Testpicture=CreateTestpicture(nrow,ncol,object_mu,object_rho,background_mu,background_rho)
    if nargin < 6
        nrow=100;
        ncol=100;
        object_mu=150;
        object_rho=10;
        background_mu=50;
        background_rho=10;
    end
    Testpicture=background_mu+background_rho+10*randn(nrow,ncol);
    Testpicture(round(2/5*nrow):round(3/5*nrow),round(2/5*ncol):round(3/5*ncol))=object_mu+object_rho+10*randn(length(round(2/5*nrow):round(3/5*nrow)),length(round(2/5*ncol):round(3/5*ncol)));
    Testpicture=uint8(Testpicture);
    imwrite(Testpicture,'my.bmp')
    imshow(Testpicture)
