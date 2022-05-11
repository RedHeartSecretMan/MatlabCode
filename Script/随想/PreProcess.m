% start
clc;
clear;

% 读取tiff图片
t1 = Tiff('D:\桌面\工作\专利\数据\brd4-580_.tif','r');
t2 = Tiff('D:\桌面\工作\专利\数据\7d4-635p.tif','r');
% 读取png图片
t3 = imread('D:\桌面\1.png');

Data1 = read(t1);
Data2 = read(t2);

close(t1)
close(t2)

% 得到强度图
Image1 = rgb2gray(Data1);
Image2 = rgb2gray(Data2);
Image3 = rgb2gray(t3);

% 定位
% BG = imopen(Image3,strel('disk',5));
% I = imsubtract(Image3, BG);
level = graythresh(Image3);
BW3 = imbinarize(Image3, level);

figure
imshow(t3)
figure
imshow(Image3)
figure
imshow(BW3)

[labeled, numObjects] = bwlabel(BW3, 8);  
% num = zeros(1, numObjects);
% for k = 1 : numObjects   % 统计每个对象的像素数                    
%     for i = 1 : size(labeled, 1)
%         for j = 1 : size(labeled, 2)
%             if labeled(i, j) == k
%                 num(1, k)=num(1, k)+1;
%             end
%         end
%     end
% end

[DisMat(:, 1), DisMat(:, 2)] = find(labeled>=1 & labeled<=max(max(labeled)));
save('MyData.mat','DisMat')

% figure
% scatter(DisMat(:, 1), DisMat(:, 2), 5, 'MarkerEdgeColor', [0 0.4470 0.7410],...
%                                        'MarkerFaceColor', [0.3010 0.7450 0.9330],...
%                                        'LineWidth', 0.1)