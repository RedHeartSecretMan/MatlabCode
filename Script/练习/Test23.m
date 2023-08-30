%%
clear;close all;clc;

%%
path = 'W:\桌面\通用人脸图像\人脸\lfw-a\二值脸1500\';
file = dir(fullfile(path, '*.png'));

for i = 1 : size(file, 1)
    
    filepathname = append(file(i).folder , '\', file(i).name);
    X = imread(filepathname);
    X = imresize(X, [800, 800]);     
    filepathnewname = append('W:\桌面\新建文件夹 (2)\', file(i).name);
    imwrite(X, filepathnewname);
    
end

%%
path = 'F:\源数据\人脸散斑1500 220 0\';
file = dir(fullfile(path, '*.png'));

for i = 1 : size(file, 1)
    
    filepathname = append(file(i).folder , '\', file(i).name);
    X = imread(filepathname);
    rect = [241 113 799 799];
    X = imcrop(X, rect);     
    filepathnewname = append('D:\桌面\新建文件夹\', file(i).name);
    imwrite(X, filepathnewname);
    
end

%%
path = 'D:\桌面\新建文件夹 (3)\新建文件夹';
file = dir(fullfile(path, '\', '*.png'));

for i = 1 : size(file, 1)
    
    filepathname = append(file(i).folder , '\', file(i).name);
    data1 = imread(filepathname);
    se = strel('disk',30');
%     se = strel('square',4'); 
    data2 = imdilate(data1, se);
%     imshowpair(data1, data2, 'montage');
    filepathnewname = append('D:\桌面\新建文件夹\', file(i).name);
    imwrite(data2, filepathnewname);
    
end