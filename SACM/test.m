% clear all;
c0 = 2;
Img = imread('my.bmp');
Img = double(Img(:,:,1));
initialLSF = ones(size(Img(:,:,1))).*c0;
initialLSF(20:80,20:80) = -c0;
LSF_1 = ones(size(Img(:,:,1))).*c0;
LSF_1(30:90,30:90) = -c0;
u = initialLSF;
u1 = LSF_1;

figure;
subplot(231);
imagesc(Img, [0, 255]);colormap(gray);hold on;axis off,axis equal
[c,h] = contour(u,[0 0],'r');
subplot(232);
imagesc(Img, [0, 255]);colormap(gray);hold on;axis off,axis equal
[c,h] = contour(u1,[0 0],'r');

[nrow,ncol]=size(Img);
bandwidth=std(Img(:))*(nrow*ncol)^(-1/5);

p_plus = ksdensity(Img(u>0),0:255,'width',bandwidth);
p_minus = ksdensity(Img(u<0),0:255,'width',bandwidth);
subplot(234);
plot(0:255,p_plus,'r',0:255,p_minus,'g');
legend('外','内');
p_plus1 = ksdensity(Img(u1>0),0:255,'width',bandwidth);
p_minus1 = ksdensity(Img(u1<0),0:255,'width',bandwidth);
subplot(235);
plot(0:255,p_plus1,'r',0:255,p_minus1,'g');
legend('外','内');

subplot(233)
imshow((xor(u>0,u1>0)));

p_plus2 = (p_plus.*sum(sum(u>0))+sum(sum(xor(u>0,u1>0))).*ksdensity(Img(xor(u>0,u1>0)),0:255,'width',bandwidth))./sum(sum(u1>0));
p_minus2 = (p_minus*sum(sum(u<0))-sum(sum(xor(u<0,u1<0)))*ksdensity(Img(xor(u<0,u1<0)),0:255,'width',bandwidth))/sum(sum(u1<0));
subplot(236);
plot(0:255,p_plus2,'r',0:255,p_minus2,'g');
legend('外','内');
% plot(0:255,p_plus2,'r');
% ---------------------------------------------------------------------------
% Img = imread('my.bmp');
% I = double(Img(:,:,1));
% [nrow,ncol] =size(I);
% 
% bandwidth=std(I(:))*(nrow*ncol)^(1/5);