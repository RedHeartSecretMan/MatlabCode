%%
clear; clc;   
I=imread('rice.png');
subplot(2,3,1); imshow(I);
subplot(2,3,2); J=immultiply(I,1.5);imshow(J);
subplot(2,3,3);
for i=1:size(I,1)
    for j=1:size(I,2)
        if I(i,j) < 125
            K(i,j)=I(i,j)-50;
        else
            K(i,j)=I(i,j)+50;
        end
    end
end
imshow(K);
subplot(2,3,4); imhist(I);ylim([0 1500]);  
subplot(2,3,5); imhist(J);ylim([0 1500]);
subplot(2,3,6); imhist(K);ylim([0 1500]);

%%
clear; clc;
max=0; min=300;
I=imread('rice.png');
subplot(2,3,1); imshow(I); title('原图','FontSize',10);
subplot(2,3,4); imhist(I); title('原图直方图','FontSize',10);
subplot(2,3,2); J=histeq(I); imshow(J); title('均值图','FontSize',10);
subplot(2,3,5); imhist(J); title('均值直方图','FontSize',10);
for i=1:size(I,1)% min(I);A=min(I);B=min(A,[],2);max(I);C=max(I),D=max(C,[],2);
    for j=1:size(I,2)
        if max<I(i,j)
            max=I(i,j);
        elseif min>I(i,j)
            min=I(i,j);
        end
    end
end
distance=max-min;
Z=(double(I)-double(min)).*255/double(distance);
Y=uint8(Z);
subplot(2,3,3);imshow(Y); title('我的均值图','FontSize',10);
subplot(2,3,6);imhist(Y); title('我的均值直方图','FontSize',10);

%%
clear;      
I =imread('rice.png');
Z=I;
level=graythresh(I);    %计算最佳阈值
a=255 * level;
for i=1:size(I,1)
    for j=1:size(I,2)
        if I(i,j) >a
            Z(i,j)=255;    %因为这里不是二值化图，所以最大应该是255，而不是1
        else
            Z(i,j)=0;
        end
    end
end
figure(1)
subplot(1,4,1);imshow(I);
subplot(1,4,2):imshow(Z);

subplot(1,4,4);imhist(Z);
subplot(1,4,3);imhist(I);
%%
clear;       
I=imread('rice.png');
BG=imopen(I,strel('disk',15));
I2=imsubtract(I,BG);
level=graythresh(I2);
BW=im2bw(I2,level);
[labeled, numObjects]=bwlabel(BW,8);  %labelded 是矩阵， numObjects是有多少团数据.8是8连接。
num=zeros(1,numObjects);
for k=1:numObjects                    %能过遍历，从labeled里寻找1-99，每个数的个数。放到一个1*99的矩阵里。
    for i=1:size(labeled,1)
        for j=1:size(labeled,2)
            if labeled(i,j)==k
                num(1,k)=num(1,k)+1;
            end
        end
    end
end
shu=numObjects
ping=mean(num)         %平均值
zui=max(num)           %从num矩阵里找到最大值。
                       %当采用下述方式时，max函数被自定义成变量了，所以不能够再使用内置函数max()
                       % max=0;
                       % for i=1:numObjects     
                       %     if max<num(1,i)
                       %         max=num(1,i);
                       %     end
                       % end
subplot(1,2,1); hist(num,20);          %将num 用直方图表示出来，分了20个bin
axis square;
[m, n]=size(I);
red_map=zeros(m,n,3);                  %因为RGB图是由三色决定的，所以给每一个像素分配一个[R G B],因为只要改红色，所以先默认[0 0 0]
for i=1:size(I,1)
    for j=1:size(I,2)
        if BW(i,j)==1
            red_map(i,j,1)=255;        %将有米粒的地方设置为[255 0 0],也就是红色
        end
    end
end
subplot(1,2,2); 
imshow(red_map); colorbar;             %通过imshow() 把矩阵 red_map 显示出来