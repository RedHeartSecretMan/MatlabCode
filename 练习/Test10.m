%%
clear; close all; clc;

%%
path_1 = 'F:\1500个 600目数\20毫米\人脸散斑1500 [800，800]';
path_2 = 'F:\1500个 600目数\20毫米\人脸散斑1500 归一化';

max_a = 0;
min_b = 255;

%%
file = dir(fullfile(path_1, '\', '*.png'));
num = size(file, 1);

for i = 1 : num
    
    filepathname = append(file(i).folder , '\', file(i).name);
    data_1 = imread(filepathname);
    
    if numel(size(data_1)) == 3
        data_2 = rgb2gray(data_1);   
    end
    
    r_1 = max(data_2, [], 'all');
    if r_1 > max_a
    max_a = r_1;
    end
    
    r_2 = min(data_2, [], 'all');
    if r_2 < min_b
    min_b = r_2;
    end
    
end

for i = 1 : num
    
    filepathname = append(file(i).folder , '\', file(i).name);
    data_3 = imread(filepathname);
    
    if numel(size(data_3)) == 3
        data_4 = rgb2gray(data_3);   
    end
    
    range = max_a - min_b;
    data_5 = double(data_4)/double(range);     
    filepathnewname = append(path_2, '\', file(i).name);
    imwrite(data_5, filepathnewname);
    
end
