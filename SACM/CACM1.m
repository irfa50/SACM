clear all;
%Img = imread('my.bmp');
Img=imread('2.bmp');
%Img=imread('3.bmp');

% Img=imread('5.bmp');
I = double(Img(:,:,1));
[nrow,ncol] =size(I);

ic=nrow/2;
jc=ncol/2;
r=35;
[X,Y] = meshgrid(1:ncol, 1:nrow);
phi_0 = sqrt((X-jc).^2+(Y-ic).^2)-r;  %³õÊ¼»¯phiÎªSDF

%delta_t = 0.1;
delta_t = 100;
%lambda=0.01*255*255;
lambda=0.00001*255*255;
%lambda=0;
epsilon=1;
bandwidth=std(I(:))*(nrow*ncol)^(-1/5);
%%
lambda_1=1;
lambda_2=1;
nu=0;
mu = 0.01*255*255;  % tune this parameter for different images
%%
figure(1);
subplot(121);
imagesc(Img, [0, 255]);colormap(gray);hold on;axis off,axis equal
title('Initial contour');
[c,h] = contour(phi_0,[0 0],'g'); 
pause();

phi=phi_0;
phi1=phi_0;
numIter = 1;
for k=1:1000
    phi=Bhattacharyya_basic(I,phi,lambda,delta_t,epsilon,bandwidth,numIter);
    %phi=AMP(I,phi,lambda,delta_t,epsilon,bandwidth,numIter);
    %phi1=EVOLUTION_CV(I, phi1, mu, nu, lambda_1, lambda_2, delta_t, epsilon, numIter); 
    if mod(k,1)==0
        pause(0.01);
%         figure(1);
        subplot(121);
        imagesc(Img, [0, 255]);colormap(gray);hold on;axis off,axis equal
        [c,h] = contour(phi,[0 0],'g');
        iterNum=[num2str(k), ' iterations'];
        title(iterNum);
        hold off;
%         subplot(1,2,2);
%         imagesc(Img, [0, 255]);colormap(gray);hold on;axis off,axis equal
%         [c,h] = contour(phi1,[0 0],'g');
%         iterNum=[num2str(k), ' iterations'];
%         title(iterNum);
%         hold off;
    end    
end;
