clc;
clear;
strs = '你我他';

strlen = length(strs);

img = imread('C:\Users\王昊\Desktop\tmp.jpg');
[high, width, channel] = size(img);

% 字符无论中英都视为两个字节
% 转换字符串
strnum = double(strs);

% 一个像素点存储一个字节，RGB分别存储高2位 中3位 低3位
pixels = high * width;
img_R = img(:, :, 1);
img_G = img(:, :, 2);
img_B = img(:, :, 3);
clear img;

if rem(pixels, 2) == 1
    pixels = pixels - 1;
end

disp(['可存储的字符个数为：', num2str(pixels / 2), '个']);

% 字符串指针
points = 1;

for each = 1 : 2 : pixels
    % 取出字符的高字节
    ch = strnum(points);
    highbits = bitand(ch, 65280) / 256;
    
    % 低字节
    lowbits = bitand(ch, 255);
    
    % 写入对应的通道中，高字节写在前，低字节写在后一个像素
    hR = bitand(highbits, 192);
    hG = bitand(highbits, 56);
    hB = bitand(highbits, 7);
    
    lR = bitand(lowbits, 192);
    lG = bitand(lowbits, 56);
    lB = bitand(lowbits, 7);
    
    % 存高字节
    % R通道的低两位存高2位
    img_R(each) = bitand(img_R(each), 252) + hR;
    % G通道的低三位存中3位
    img_G(each) = bitand(img_G(each), 248) + hG;
    % G通道的低三位存低3位
    img_B(each) = bitand(img_B(each), 248) + hB;
    
    % 存低字节
    img_R(each + 1) = bitand(img_R(each + 1), 252) + lR;
    img_G(each + 1) = bitand(img_G(each + 1), 252) + lG;
    img_B(each + 1) = bitand(img_B(each + 1), 252) + lB;
    
    points = points + 1;
    if points > strlen
        break;
    end
end




img(:, :, 1) = img_R;
img(:, :, 2) = img_G;
img(:, :, 3) = img_B;
imwrite(img, 'C:\Users\王昊\Desktop\123.bmp')