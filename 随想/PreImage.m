%% Initialize
clear; close all; clc;

%% Gray
path = 'D:\桌面\工作\数据\人脸\数据集\lfw-a\';
file = dir(fullfile(path, '*', '*.jpg'));

for i = 1 : size(file, 1)
    
    filepathname = append(file(i).folder, '\', file(i).name);
    headdata1 = imread(filepathname);
    isrgb = numel(size(headdata1));
    if isrgb == 3
        headdata1 = rgb2gray(headdata1);
    end
    newname = append(num2str(i), '.png');
    filepathnewname = append('D:\桌面\新建文件夹\', newname);
    imwrite(headdata1, filepathnewname);
    
end

%% Cutting
path1 = 'D:\桌面\新建文件夹\';
file1 = dir(fullfile(path1, '*.png'));

for i = 1 : size(file1, 1)
    
    file1path1name = append(file1(i).folder, '\', file1(i).name);
    headdata2 = imread(file1path1name);
    [L1, a1, a2, L2, b1, b2, L3] = PositionImage(headdata2);
%     disp([L1, L2, L3]);
    headdata3 = imcrop(headdata2, [L1, L2, L3, L3]);     % 截图起点为左顶点[L1, L2]，L1为列，L2为行，大小[L3, L3]
    newname = append(num2str(i), '.png');
    file1path1newname = append('D:\桌面\新建文件夹 (2)\', newname);
    imwrite(headdata3, file1path1newname);
    
end

%% Classify
path2 = 'D:\桌面\新建文件夹 (2)\';
file2 = dir(fullfile(path2, '*.png'));
C = zeros(size(file2, 1), 1);

for i = 1 : size(file2, 1)
    
    file2path2name = append(file2(i).folder, '\', file2(i).name);
    headdata4 = imread(file2path2name);
    
    % 均方根对比度
    fxy = headdata4;
    register = 0;
    m = mean(fxy, 'all');
    
    for r = 1 : size(fxy ,1)
        for c = 1 : size(fxy ,2)
            register = register + (double(fxy(r ,c)) - m)^2;
        end
    end
    
    MN = size(fxy ,1)*size(fxy ,2);
    C(i) = sqrt(register/MN);
    
end

X = sort(C);
threshold = X(end-4000);
    
for i = 1 : size(file2, 1)
     
    if C(i) >= threshold 
      
        file2path2name = append(file2(i).folder, '\', file2(i).name);
        headdata5 = imread(file2path2name);
        newname = append(num2str(i) ,'.png');
        file2path2newname = append('D:\桌面\新建文件夹 (3)\' ,newname);
        imwrite(headdata5 ,file2path2newname);
        
    end
    
end    

%% Imbinarize
path3 = 'D:\桌面\新建文件夹 (2)\';
file3 = dir(fullfile(path3 ,'*.png'));

for i = 1 : size(file3 ,1)
    
    file3path3name = append(file3(i).folder, '\', file3(i).name);
    headdata6 = imread(file3path3name);
    T = graythresh(headdata6);   % 全局阈值
%     T = adaptthresh(headdata6, 0.5, 'NeighborhoodSize', 2*floor(size(c)/16)+1, 'ForegroundPolarity', 'dark', 'Statistic', 'gaussian');   % 局部阈值 
    headdata7 = imbinarize(headdata6, T);
    bw1=imbinarize(c,j); imshow(bw1);
    newname = append(num2str(i) ,'.png');
    file3path3newname = append('D:\桌面\新建文件夹 (3)\', newname);
    imwrite(headdata7, file3path3newname);
    
end

%% Strengthen
path4 = 'D:\桌面\新建文件夹\';
file4 = dir(fullfile(path4 ,'*.png'));

for k = 1 :size(file4 ,1)
    file4path4name = append(file4(k).folder, '\', file4(k).name);
    Zij = imread(file4path4name);
    [L1, a1, a2, L2, b1, b2, L3] = PositionImage(Zij);
%     disp([a1, a2, b1, b2]);
       
    Image1 = imcrop(Zij, [a1, b1, a2-a1, b2-b1]);
    level = graythresh(Image1);     % 面部最佳灰度阈值
    
    aij = Zij;
    Fan1 = 0.65;     %暗部增强系数
    Fan2 = 0.85;     %亮部减弱系数
    max1 = Fan1*double(max(max(aij)));
    min1 = Fan2*double(min(min(aij)));
    J = 255/(max1-min1);     %防止溢出映射系数
    [m, n] = size(Zij);
    
    for i = 1 : n
        if ((i >= a1) && (i <= a2))
            for j = 1 : m
                if ((j >= b1) && (j <= b2))
                    if aij(i, j) < level*255     % 目标区域
                        aij(i, j) = aij(i, j)*Fan1*J;     % 暗部
                    else
                        aij(i, j) = uint8(uint16(aij(i, j)*Fan2)*J);     % 亮部
                    end
                else
                    if aij(i, j) < level*255     % 2, 7区域
                        aij(i, j) = aij(i, j)*Fan1*J;
                    else
                        aij(i, j) = uint8(uint16(aij(i, j)*Fan2)*J);
                    end
                end
            end
        else
            for j = 1 : m
                if aij(i, j) < level*255     % 1, 4, 6, 3, 5, 8 区域
                    aij(i, j) = aij(i, j)*Fan1*J;
                else
                    aij(i, j) = uint8(uint16(aij(i, j)*Fan2)*J);
                end
            end
        end
    end
    
    Image2 = imcrop(aij, [L1, L2, L3, L3]);
    newname = append(num2str(k), '.png');
    file4path4newname = append('D:\桌面\新建文件夹 (5)\', newname);
    imwrite(Image2, file4path4newname);
    
end
