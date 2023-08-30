%%
x=linspace(0,2*pi,1000);
y=sin(x);
a=plot(x,y);
set(gcf,'color',[1,1,1]);
% һ
set(gca, 'FontSize', 25);
% ��
set(gca, 'XTick', 0:pi/2:2*pi);
set(gca, 'XTickLabel', 0:90:360);
% ��
set(gca, 'XTickLabel', {'0', '\pi/2', '\pi', '3\pi/2', '2\pi'});

%%
clear, close all
I = imread('pout.tif'); %��ȡͼ������
imshow(I); %��ʾ����ͼ��

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
J=immultiply(I, 1.5);%ͼ��˷�ʹ�þ����˻���ѭ���˷�Ҳ�ǿ��Ե�
subplot(1,3,2); imshow(J); 
K=imrotate(I, 35, 'bilinear');%bilinear˫���� 
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
I = imread('pout.tif'); I2 = histeq(I);%equalization function��ֵ����
subplot(1,4,1); imhist(I);
subplot(1,4,2); imshow(I);
subplot(1,4,3); imshow(I2);
subplot(1,4,4); imhist(I2);

%%
I = imread('rice.png'); imhist(I);
level=graythresh(I);% �ҳ�����ʵĻҽ���ֵ
bw=imbinarize(I, level);%������ֵ��ͼ��ת��Ϊ��ֵͼ�� 
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
BG = imopen(I, strel('disk', 15));%��I������strel��~����̬�ṹԪ�ظ�ʴ��
subplot(1,3,2); imshow(BG);
I2 = imsubtract(I, BG); 
level=graythresh(I2); bw2 = imbinarize(I2, level);% BW2=imbinarize(I2,'adaptive','ForegroundPolarity','dark','Sensitivity',0.4);
subplot(1,3,3); imshow(bw2);

%%
I=imread('rice.png');
BG=imopen(I, strel('disk', 15));
I2=imsubtract(I, BG); level=graythresh(I2); 
BW=imbinarize(I2, level); 
[labeled, numObjects]=bwlabel(BW, 8);%����labeled������BW��8ͨ·������ʽ�Ľ����������������4ͨ·������ʽ��
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
RGB_label=label2rgb(labeled); imshow(RGB_label);%�Ҷ�ͼתΪ���ͼ
%%
clear;  
I=imread('rice.png');   level=graythresh(I);
bw=imbinarize(I,level);
subplot(2,2,1); imshow(bw);      %ֱ���ù���ֵ��ֵ��
BG=imopen(I,strel('disk',15));
I2=imsubtract(I,BG);    level=graythresh(I2);
bw2=imbinarize(I2,level);
subplot(2,2,2); imshow(bw2);     %ԭͼ��ȥ��ʴͼ���ı�����ȥ��ֵ���ж�ֵ��
BG1=imopen(I,strel('disk',4));   %��ʴ�뾶����Ϊ4����
level1=graythresh(BG1);          %����ͼ����ֵ
bw3=imbinarize(BG1,level1);      %�ô˲�ͬ��ֵ���ж�ֵ��
subplot(2,2,3); imshow(BG1);
subplot(2,2,4); imshow(bw3);     