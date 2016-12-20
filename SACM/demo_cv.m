%   Matlab code implementing Chan-Vese model in the paper 'Active Contours Without Edges'
%   This method works well for bimodal images, for example the image 'three.bmp'
%   created on 04/26/2004
%   This code is written by Chunming Li, all right reserved
%   email: li_chunming@hotmail.com

clear;

% three images are provided for test
%Img=imread('three.bmp');     % example that CV model works well
%Img=imread('vessel.bmp');    % example that CV model does NOT work well
%Img=imread('zaod0.jpg');  % example that CV model does NOT work well
%Img=imread('caid.bmp');

%Img=imread('1.bmp');
%Img=imread('4.bmp');
%Img=imread('5.bmp');
Img=imread('my.bmp')

U=Img(:,:,1);
[nrow,ncol] =size(Img);
Img2=ones(nrow,ncol);
% get the size
[nrow,ncol] =size(U);

ic=nrow/2;
jc=ncol/2;
r=15;

%phi_0 = sdf2circle(nrow,ncol,ic,jc,r);
[X,Y] = meshgrid(1:ncol, 1:nrow);
phi_0 = sqrt((X-jc).^2+(Y-ic).^2)-r;  %初始化phi为SDF

delta_t = 0.1;
lambda_1=1;
lambda_2=1;
nu=0;
h = 1;
epsilon=1;
mu = 0.01*255*255;  % tune this parameter for different images

figure;%显示初始化图像 figure1
imshow(Img);colormap
hold on;

%plotLevelSet(phi_0,0,'g');
[c,h] = contour(phi_0,[0 0],'g'); 
hold off;

I=double(U);
% iteration should begin from here
phi=phi_0;

%显示进化图像
figure;
imshow(Img);colormap
hold on;
%plotLevelSet(phi,0,'g');
[c,h] = contour(phi,[0 0],'g');
hold off;

numIter = 1;
time = cputime;
for k=1:5000,
    phi=EVOLUTION_CV(I, phi, mu, nu, lambda_1, lambda_2, delta_t, epsilon, numIter);   % update level set function
    if mod(k,5)==0
        pause(0.01);
        imshow(Img);colormap
        hold on;
        
        %plotLevelSet(phi,0,'g');
        [c,h] = contour(phi,[0 0],'g'); 
        
        iterNum=[num2str(k), ' iterations'];
        title(iterNum);
        hold off;
    end    
end;
totaltime = cputime - time%计算从time = cputime开始到此句的时间差
