%% initialize

clear; close all; clc;     % 打扫环境
path = '/Users/WangHao/学习/Pycharm/MyNet/all_image/label';     % 选择数据存放的文件夹路径
file = dir(fullfile(path, '*.png'));     % 显示文件夹下所有符合后缀名为.jpg文件的完整信息

%% binarize

for i = 1 : size(file ,1)
    
    filepathname = append(file(i).folder ,'\',file(i).name);
    headdata1 = imread(filepathname);
%     headdata2 = medfilt2(headdata1, [3, 3]);
%     figure; imshowpair(headdata1, headdata2, 'montage')
    headdata2 = imbinarize(headdata1);
%     headdata4 = imbinarize(headdata1);
%     figure; imshowpair(headdata4, headdata3, 'montage')
%     newname = append(num2str(i), '.png');
    filepathnewname = append('D:\桌面\新建文件夹\', file(i).name);
    imwrite(headdata2, filepathnewname);
    
end
        
%% 左右翻转
tic
for i = 1 : size(file ,1)
    
    filepathname = append(file(i).folder ,'/',file(i).name);
    headdata1 = imread(filepathname);
    headdata2 = fliplr(headdata1);
    filepathnewname = append('/Users/WangHao/学习/Pycharm/MyNet/all_image/label/', file(i).name);
    imwrite(headdata2, filepathnewname);
    
end
toc
