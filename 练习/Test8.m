clear; clc;
train_pre_namelist=dir('D:\桌面\人脸\人脸\脸白\*.png');
[Num,~]=size(train_pre_namelist);
Grating = double(imread('D:\桌面\工作\数据\光栅\光栅1.png'));
s1 = 700; s2 = 256;
for i = 1:Num
    
listname = train_pre_namelist(i).name;   
Image1 = double(importdata(['D:\桌面\人脸\人脸\脸白\', listname]));
Image2 = 1 - (Image1./Grating);
Image3 = 1 - Image2;
Image3 = imbinarize(Image3);

  for m=1:1200
        for n=1:1920
            if Image3(m,1247)>0||Image3(m,1249)>0
                Image3(m,1248) = 1;
            end
            if Image3(m,911)>0||Image3(m,913)>0
                Image3(m,912) = 1;
            end
        end
  end
  
 Image4 = Image3(600-s1/2+1:600+s1/2,960-s1/2+1:960+s1/2); 
 Image4 = imresize(Image4, [s2, s2]);
 imwrite(Image4, ['D:\桌面\新建文件夹\', listname])
 
end
 