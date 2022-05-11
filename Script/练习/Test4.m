%% initialize

clear; close all; clc;

%% contrast compute

C = zeros(1 ,5751);     %4099

for num = 1 :10     %4101
    
    % read data
    
    filepath = 'D:\桌面\工作\其他\数据\数据\灰度\';
    name = append(num2str(num) ,'.png');     %对于包含string的表达式可以使用“+”代替append直接合并文本
    filepathname = append(filepath ,name);
    facedata = imread(filepathname);     %地址char与string皆可
    fxy = imcrop(facedata,[55 30 159 159]);
    
    % contrast compute
    
    register1 = 0;
    register2 = 0;
    for i = 1 :size(fxy ,1)
        for j = 1 :size(fxy ,2)
            register1 = register1 + double(fxy(i ,j))^2;
            register2 = register2 + double(fxy(i ,j));
        end
    end
    
    N = size(fxy ,1)*size(fxy ,2);
%     C(num-2) = sqrt((register1/N)-((register2/N)^2))/(register2/N);
    C(num) = sqrt((register1/N)-((register2/N)^2))/(register2/N);
    
end

%% contrast classify

register3 = 0;
[nbins ,edges] = histcounts(C,5751);     %依据数据量分盒子数
% [nbins ,edges] = histcounts(C);

% set limit

percent = 0.2457;     %筛选率

for register4 = 1 :size(nbins,2)
    register3 = nbins(end-register4+1) + register3;
    if register3/size(nbins ,2) >= percent
        threshold = edges(end-register4);
        break
    end
end

% write data

% register5 = 0;
% register6 = 1;
for num = 3 :5751     %4101
    
    if C(num) > threshold
        filepath = 'D:\桌面\工作\其他\数据\Face\100_tran_gray\';
        name = append(num2str(num) ,'.png');
        filepathname = append(filepath ,name);
        facedata = imread(filepathname);
        newfilepath = 'D:\桌面\工作\其他\数据\Face\AimFace1\';
%         register5 = register5 + register6;
%         newnum = register5;
        newnum = num;
        newname = append(num2str(newnum) ,'.png');
        newfilepathnewname = append(newfilepath ,newname);
        imwrite(facedata ,newfilepathnewname);
    end
    
end
    
%% constrast visualization

histogram(C ,50);
title('对比度分布直方图')
