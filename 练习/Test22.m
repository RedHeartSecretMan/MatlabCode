clear; close all; clc;
path = 'D:\桌面';
file = dir(fullfile(path, '\', 'label_01_test.txt'));
num1 = size(file, 1);

%%
for i = 1 : num1
    
    filepathname = append(file(i).folder , '\', file(i).name);
    D = readtable(filepathname, 'Delimiter', ' ', 'ReadVariableNames', false);  % 分割符采用 ，不读取变量名
    A = table2array(D);
    
end

%%
num2 = size(A, 1);
B = cell(num2, 1);
C = cell(num2, 1);

for i = 1 : num2

B(i, 1) = erase(A(i, 2), '2\');    
C(i, 1) = append('D:\桌面\新建文件夹\', B(i, 1));
% fprintf(filepathnewname, '\n', C(i, 1));  

end

writecell(C, 'D:\桌面\新建文本文档.txt');  % 写入txt
