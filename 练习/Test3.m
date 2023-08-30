%% initialize

clear; close all; clc;     % 打扫环境
path = 'W:\桌面\工作\数据\lfw-deepfunneled\';     % 设置数据存放的文件夹路径
file = dir(fullfile(path,'*','*.jpg'));     % 显示文件夹下所有符合后缀名为.jpg文件的完整信息

%% gray

for i = 1 :size(file ,1)
    
    filepathname = append(file(i).folder,'\',file(i).name);
    headdata1 = imread(filepathname);
    headdata2 = rgb2gray(headdata1);
    newname = append(num2str(i) ,'.png');
    filepathnewname = append('W:\桌面\工作\数据\灰度\',newname);
    imwrite(headdata2 ,filepathnewname);
    
end

%% cutting

for i = 1 :size(file ,1)
    
    filepathname = append(file(i).folder,'\',file(i).name);
    headdata1 = imread(filepathname);
    headdata2 = rgb2gray(headdata1);
    headdata3 = imcrop(headdata2,[50,30,169,169]);     % 参考左顶点[50 ,35]，大小[170 ,170]
    newname = append(num2str(i) ,'.png');
    filepathnewname = append('W:\桌面\工作\数据\裁切\',newname);
    imwrite(headdata3 ,filepathnewname);
    
end

for i = 1 :size(file ,1)
    
    filepathname = append(file(i).folder,'\',file(i).name);
    headdata1 = imread(filepathname);
    headdata2 = rgb2gray(headdata1);
    headdata3 = imcrop(headdata2,[35,20,174,174]);    
    newname = append(num2str(i) ,'.png');
    filepathnewname = append('W:\桌面\工作\数据\裁切1\',newname);
    imwrite(headdata3 ,filepathnewname);
    
end

for i = 1 :size(file ,1)
    
    filepathname = append(file(i).folder,'\',file(i).name);
    headdata1 = imread(filepathname);
    headdata2 = rgb2gray(headdata1);
    headdata3 = imcrop(headdata2,[25,10,179,179]);     
    newname = append(num2str(i) ,'.png');
    filepathnewname = append('W:\桌面\工作\数据\裁切2\',newname);
    imwrite(headdata3 ,filepathnewname);
    
end
%% classify & strengthen

 C = zeros(size(file ,1),1);

for i = 1 :size(file ,1)
    
    filepathname = append(file(i).folder,'\',file(i).name);
    headdata1 = imread(filepathname);
    headdata2 = rgb2gray(headdata1);
    headdata3 = imcrop(headdata2,[50,40,159,159]);     % 参考左顶点[50 ,40]，大小[160 ,160]
    fxy = headdata3;
    
    % contrast compute
    
    register1 = 0;
    register2 = 0;
    
    for r = 1 :size(fxy ,1)
        for c = 1 :size(fxy ,2)
            register1 = register1 + double(fxy(r ,c))^2;
            register2 = register2 + double(fxy(r ,c));
        end
    end
    
    N = size(fxy ,1)*size(fxy ,2);
    C(i) = sqrt((register1/N)-((register2/N)^2))/(register2/N);
    
end

X = sort(C);
threshold = X(end-1199);
    
for i = 1 :size(file ,1)
    
    if C(i) >= threshold 
        newname = append(num2str(i) ,'.png');
        filepathname = append('W:\桌面\工作\数据\裁切\',newname);
        headdata4 = imread(filepathname);
        filepathnewname1 = append('W:\桌面\工作\数据\筛选3\',newname);
        imwrite(headdata4 ,filepathnewname1);
%         headdata5 = histeq(headdata4);
%         filepathnewname2 = append('W:\桌面\工作\数据\增强\',newname);
%         imwrite(headdata5 ,filepathnewname2);
    end
    
end    

 C = zeros(size(file ,1),1);

for i = 1 :size(file ,1)
    
    filepathname = append(file(i).folder,'\',file(i).name);
    headdata1 = imread(filepathname);
    headdata2 = rgb2gray(headdata1);
    headdata3 = imcrop(headdata2,[50,40,159,159]);    
    fxy = headdata3;
    
    % contrast compute
    
    register1 = 0;
    register2 = 0;
    
    for r = 1 :size(fxy ,1)
        for c = 1 :size(fxy ,2)
            register1 = register1 + double(fxy(r ,c))^2;
            register2 = register2 + double(fxy(r ,c));
        end
    end
    
    N = size(fxy ,1)*size(fxy ,2);
    C(i) = sqrt((register1/N)-((register2/N)^2))/(register2/N);
    
end

X = sort(C);
threshold = X(end-1199);
    
for i = 1 :size(file ,1)
    
    if C(i) >= threshold 
        newname = append(num2str(i) ,'.png');
        filepathname = append('W:\桌面\工作\数据\裁切\',newname);
        headdata4 = imread(filepathname);
        filepathnewname1 = append('W:\桌面\工作\数据\筛选4\',newname);
        imwrite(headdata4 ,filepathnewname1);
%         headdata5 = histeq(headdata4);
%         filepathnewname2 = append('W:\桌面\工作\数据\增强\',newname);
%         imwrite(headdata5 ,filepathnewname2);
    end
    
end    

 C = zeros(size(file ,1),1);

for i = 1 :size(file ,1)
    
    filepathname = append(file(i).folder,'\',file(i).name);
    headdata1 = imread(filepathname);
    headdata2 = rgb2gray(headdata1);
    headdata3 = imcrop(headdata2,[50,40,159,159]);     
    fxy = headdata3;
    
    % contrast compute
    
    register1 = 0;
    register2 = 0;
    
    for r = 1 :size(fxy ,1)
        for c = 1 :size(fxy ,2)
            register1 = register1 + double(fxy(r ,c))^2;
            register2 = register2 + double(fxy(r ,c));
        end
    end
    
    N = size(fxy ,1)*size(fxy ,2);
    C(i) = sqrt((register1/N)-((register2/N)^2))/(register2/N);
    
end

X = sort(C);
threshold = X(end-1199);
    
for i = 1 :size(file ,1)
    
    if C(i) >= threshold 
        newname = append(num2str(i) ,'.png');
        filepathname = append('W:\桌面\工作\数据\裁切\',newname);
        headdata4 = imread(filepathname);
        filepathnewname1 = append('W:\桌面\工作\数据\筛选5\',newname);
        imwrite(headdata4 ,filepathnewname1);
%         headdata5 = histeq(headdata4);     %直方图均衡法
%         filepathnewname2 = append('W:\桌面\工作\数据\增强\',newname);
%         imwrite(headdata5 ,filepathnewname2);
    end
    
end    