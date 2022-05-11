Image = imread('D:\桌面\1.png');
[r, c] = size(Image);
% 0.2989 * R + 0.5870 * G + 0.1140 * B
R = im2double(Image)/0.2989;
G = im2double(Image)/0.5870;
B = im2double(Image)/0.1140;
RGB = cat(3 ,R ,G ,B);
RGB = im2uint8(RGB);

% imshowpair(Image, RGB, 'montage');
imwrite(uint8(RGB),'D:\桌面\2.png')