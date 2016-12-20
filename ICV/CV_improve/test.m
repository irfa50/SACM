% This Matlab file demomstrates a level set algorithm based on Kaihua Zhang et al's paper:
%    "Improved C-V Active Contour Model" published by OPTO-ELECTRONIC ENGINEERING (2008)
% Author: Kaihua Zhang, all rights reserved
% E-mail: zhkhua@mail.ustc.edu.cn 
% http://www4.comp.polyu.edu.hk/~cskhzhang/

clc;clear all;close all;
%Img = imread('plane4.jpg');
Img=imread('e.bmp');
Img = Img(:,:,1);
Img = double(Img);
[row,col] = size(Img);
%----------------------
phi = zeros(row,col);
I_Area = row*col;
I_M = sum(Img(:));
epsilon = 1.5;
delt = 1.5;

for n = 1:50 
    phi = CV_Imp2D(phi,Img,I_Area,I_M,epsilon,delt);
   
    imshow(uint8(Img));hold on;
    %imagesc(Img,[0 255]);colormap(gray);hold on;
    [c,h] = contour(phi,[0 0],'b');
    iterNum = [num2str(n),'iterations'];
    title(iterNum);
    hold off;
    pause(0.01);
 
end
    