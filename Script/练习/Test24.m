% clc;clear;close all; 
% pic=imread('D:\桌面\3019.png');
% graypic=rgb2gray(x1);
double_pic=im2double(x);
[width,height]=size(double_pic);
double_pic = imnoise(double_pic,'salt & pepper',0.1);
H=fspecial('average', 35);  % 生成9x9均值滤波器,图像更模糊，3x3几乎看不出差别
img=imfilter(double_pic, H, 'conv', 'circular');  %使用卷积滤波，默认是相关滤波
img=imnoise(img,'speckle', 0.1);

imshowpair(x, img, 'montage');
imwrite(img, 'D:\桌面\6.png');
