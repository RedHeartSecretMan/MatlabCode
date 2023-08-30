% 叠加光栅
 close all; clear; clc;
train_pre_namelist=dir('D:\桌面\123\*.png');
[Num,~]=size(train_pre_namelist);
Grating = double(imread('D:\桌面\工作\数据\光栅\光栅1.png'));
figure;imshow(uint8(Grating))
[status, msg] = mkdir('D:\桌面\123456');
s = 800;

for i = 1 : Num
    
    listname = train_pre_namelist(i).name;
    listpath = train_pre_namelist(i).folder;
    Image = double(imread([listpath, '/', listname]));
%     figure;imshow(uint8(Image))
    
    Image = 255 - Image;
%     figure;imshow(uint8(Image))
    
    Image = imresize(Image, [s, s]);
    Image1 = ones(1200, 1920) * 255;
    Image1(600-s/2+1:600+s/2,960-s/2+1:960+s/2) = Image;
%     figure;imshowpair(uint8(Image1), uint8(255 - Image1), 'montage')
    
    Image2 = (255 - Image1) + Grating;
    Image3 = Image2;
%     figure;imshow(uint8(Image2))
    
    for m=1:1200
        for n=1:1920
            if Image2(m,n) > 255
                Image3(m,n) = Image3(m,n) - 256;
            end
        end
    end
    
%     figure;imshow(uint8(Image3))
    Image = uint8(Image3);
    imwrite(Image,['D:\桌面\123456\', listname])
    
end
