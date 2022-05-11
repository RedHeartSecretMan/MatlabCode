clear; close all; clc;
path = 'D:\桌面\1\';
file = dir(fullfile(path, '*.tif'));

for i=1:600
    
    filepathname = append(file(i).folder , '\', file(i).name);
    t = Tiff(filepathname,'r');
    [RGB,~] = readRGBAImage(t);
    close(t);
    rect = [241 113 799 799];
    X = imcrop(RGB, rect);     
    filepathnewname = append('D:\桌面\新建文件夹\', file(i).name);
    imwrite(X, filepathnewname);
    
end