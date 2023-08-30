%%
x=linspace(0,2*pi,1000);
y=sin(x);
a=plot(x,y);
set(gcf,'color',[1,1,1]);
% 一
set(gca, 'FontSize', 25);
% 二
set(gca, 'XTick', 0:pi/2:2*pi);
set(gca, 'XTickLabel', 0:90:360);
% 三
set(gca, 'XTickLabel', {'0', '\pi/2', '\pi', '3\pi/2', '2\pi'});

%%
clear, close all
I = imread('pout.tif'); %读取图像数据
imshow(I); %显示数据图像

for i=1:size(I,1)
    for j=1:size(I,2)
        if(rem(i,2)==0 && rem(j,2)==0)
            I(i,j)=0;
        end
    end
end

imshow(I);
colorbar;

%%
I=imread('rice.png'); 
subplot(1,3,1); imshow(I);
J=immultiply(I, 1.5);%图像乘法使用矩阵点乘或者循环乘法也是可以的
subplot(1,3,2); imshow(J); 
K=imrotate(I, 35, 'bilinear');%bilinear双线性 
subplot(1,3,3); imshow(K);
size(I)
size(J)
size(K)

%%
I=imread('rice.png'); 
J=imread('cameraman.tif'); K=imadd(I,J); 
subplot(1,3,1); imshow(I); 
subplot(1,3,2); imshow(K);
subplot(1,3,3); imshow(J);

%%
I = imread('pout.tif'); I2 = histeq(I);%equalization function均值函数
subplot(1,4,1); imhist(I);
subplot(1,4,2); imshow(I);
subplot(1,4,3); imshow(I2);
subplot(1,4,4); imhist(I2);

%%
I = imread('rice.png'); imhist(I);
level=graythresh(I);% 找出最合适的灰阶阈值
bw=imbinarize(I, level);%基于阈值将图像转换为二值图像 
subplot(1,2,1); imshow(I); 
subplot (1,2,2); imshow(bw);

%%
I=imread('printedtext.png');                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
subplot (1,2,1);imshow(I);
title('Original Image');
BW=imbinarize(I,'adaptive','ForegroundPolarity','dark','Sensitivity',0.4);
subplot (1,2,2);imshow(BW);
title('Binary Version of Image');

%%
I = imread('rice.png'); level=graythresh(I);
bw = imbinarize(I, level); 
subplot (1,3,1); imshow(bw);
BG = imopen(I, strel('disk', 15));%把I中满足strel（~）形态结构元素腐蚀掉
subplot(1,3,2); imshow(BG);
I2 = imsubtract(I, BG); 
level=graythresh(I2); bw2 = imbinarize(I2, level);% BW2=imbinarize(I2,'adaptive','ForegroundPolarity','dark','Sensitivity',0.4);
subplot(1,3,3); imshow(bw2);

%%
I=imread('rice.png');
BG=imopen(I, strel('disk', 15));
I2=imsubtract(I, BG); level=graythresh(I2); 
BW=imbinarize(I2, level); 
[labeled, numObjects]=bwlabel(BW, 8);%创建labeled数组存放BW中8通路检索方式的结果（仅上下左右是4通路检索方式）
A=zeros(numObjects,1);
for m=1:numObjects
    n=0;
    for i=1:256
        for j=1:256
            if labeled(i,j)==m
                n=n+1;
            end
        end
    end
    A(m,:)=n;   
end
[Max,num]=max(A);Mean=mean(A);
RGB_label=label2rgb(labeled); imshow(RGB_label);%灰度图转为真彩图
%%
clear;  
I=imread('rice.png');   level=graythresh(I);
bw=imbinarize(I,level);
subplot(2,2,1); imshow(bw);      %直接用过阈值二值化
BG=imopen(I,strel('disk',15));
I2=imsubtract(I,BG);    level=graythresh(I2);
bw2=imbinarize(I2,level);
subplot(2,2,2); imshow(bw2);     %原图减去腐蚀图像后的背景再去阈值进行二值化
BG1=imopen(I,strel('disk',4));   %腐蚀半径设置为4像素
level1=graythresh(BG1);          %将此图求阈值
bw3=imbinarize(BG1,level1);      %用此不同阈值进行二值化
subplot(2,2,3); imshow(BG1);
subplot(2,2,4); imshow(bw3);     