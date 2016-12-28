clear all;
Img = imread('my2.bmp');
Img_prior=imread('my.bmp');
%Img = imread('sample.bmp');
%Img=imread('2.bmp');
%Img=imread('3.bmp');
% Img=imread('5.bmp');
I = double(Img(:,:,1));
I_prior=double(Img_prior(:,:,1));
[nrow,ncol] =size(I);
%% ��ʼˮƽ��
ic=nrow/2;
jc=ncol/2;
r=25;
[X,Y] = meshgrid(1:ncol, 1:nrow);
phi_0 = sqrt((X-jc).^2+(Y-ic).^2)-r;  %��ʼ��phiΪSDF
%% SACM����
%delta_t = 0.1;
delta_t = 100;
%lambda=0.01*255*255;
lambda=0.00001*255*255;
%lambda=0;
epsilon=1;
bandwidth=std(I(:))*(nrow*ncol)^(-1/5);
%% CV����
lambda_1=1;
lambda_2=1;
nu=0;
mu = 0.01*255*255;  % tune this parameter for different images
%% ����
phi_prior=ones(100,100);
phi_prior(40:60,40:60)=-1;
p_plus_prior=ksdensity(I_prior(phi_prior>0),0:255,'width',bandwidth);
p_minus_prior=ksdensity(I_prior(phi_prior<0),0:255,'width',bandwidth);
figure(2);
title('prior contour');
subplot(121);
imagesc(Img_prior, [0, 255]);colormap(gray);hold on;axis off,axis equal
title('prior contour');
[c,h] = contour(phi_prior,[0 0],'g'); hold off;
subplot(122);
plot(0:255,p_plus_prior,'r',0:255,p_minus_prior,'g');
legend('out','int')
%% �������
lambda_p1=1;
lambda_p2=1;
%% main
figure(1);
subplot(121);
imagesc(Img, [0, 255]);colormap(gray);hold on;axis off,axis equal
title('Initial contour');
[c,h] = contour(phi_0,[0 0],'g'); hold off;
subplot(122);
p_plus = ksdensity(I(phi_0>0),0:255,'width',bandwidth);
p_minus = ksdensity(I(phi_0<0),0:255,'width',bandwidth);
plot(0:255,p_plus,'r',0:255,p_minus,'g');
legend('out','int')
pause();

phi=phi_0;
numIter = 1;
for k=1:1000
    %phi=Bhattacharyya(I,phi,lambda,delta_t,epsilon,bandwidth,numIter);
    phi=Bhattacharyya_prior(I,phi,lambda,delta_t,epsilon,p_plus_prior,p_minus_prior,lambda_p1,lambda_p2,bandwidth,numIter);
    %phi=AMP(I,phi,lambda,delta_t,epsilon,bandwidth,numIter);
    %phi=MI(I,phi,lambda,delta_t,epsilon,bandwidth,numIter);
    %phi1=EVOLUTION_CV(I, phi1, mu, nu, lambda_1, lambda_2, delta_t, epsilon, numIter); 
    if mod(k,1)==0
        pause(0.01);
        figure(1);
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
