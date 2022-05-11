close all;clear;clc;

F = imread('D:\桌面\工作\其他\数据\数据\筛选\29.png'); 
[m,n]=size(F); 
G=zeros(m,n);  
w=[0,1,0;1,-4,1;0,1,0]; 

for x=1:m     
    for y=1:n         
        if (x==1||y==1||x==m||y==n)            
            G(x,y)=F(x,y);         
        else
            G(x,y)=w(1,1)*F(x-1,y-1)+w(1,2)*F(x-1,y)+w(1,3)*F(x-1,y+1)...                 
                +w(2,1)*F(x,y-1)+w(2,2)*F(x,y)+w(2,3)*F(x,y+1)...                 
                +w(3,1)*F(x+1,y+1)+w(3,2)*F(x+1,y)+w(3,3)*F(x+1,y+1);                     
        end
    end
end

figure 
subplot(1,2,1) 
imshow(F) 
title('原始图像'); 
subplot(1,2,2) 
imshow(uint8(G)); 
title('拉普拉斯算子处理后的图像');
imwrite(G,'2.png')