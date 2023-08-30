%% initialize

clear; close all; clc;     % 打扫环境
path = 'D:\桌面\工作\数据\人脸\裁切\';     % 选择数据存放的文件夹路径
file = dir(fullfile(path, '*.png'));     % 显示文件夹下所有符合后缀名为.jpg文件的完整信息

%% binarize

for i = 1 : size(file ,1)
    
    filepathname = append(file(i).folder ,'\',file(i).name);
    headdata1 = imread(filepathname);
    headdata2 = medfilt2(headdata1, [3, 3]);
    % figure; imshowpair(headdata1, headdata2, 'montage')
    
    fxy = headdata2;
    register1 = 0;
    register2 = 0;
    
    for r = 1 :size(fxy ,1)
        for c = 1 :size(fxy ,2)
            register1 = register1 + double(fxy(r ,c))^2;
            register2 = register2 + double(fxy(r ,c));
        end
    end
    
    N = size(fxy ,1)*size(fxy ,2);
    C = sqrt((register1/N)-((register2/N)^2))/(register2/N);
    
    if C < 0.66
        
        headdata3 = imbinarize(headdata2);
        headdata4 = imbinarize(headdata1);
%         figure; imshowpair(headdata4, headdata3, 'montage')
        newname = append(num2str(i), '.png');      
        filepathnewname = append('D:\桌面\新建文件夹3\', newname);
        imwrite(headdata1, filepathnewname);
        
    end
    
end
