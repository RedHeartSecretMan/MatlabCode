clc;
clear;
strs = '������';

strlen = length(strs);

img = imread('C:\Users\���\Desktop\tmp.jpg');
[high, width, channel] = size(img);

% �ַ�������Ӣ����Ϊ�����ֽ�
% ת���ַ���
strnum = double(strs);

% һ�����ص�洢һ���ֽڣ�RGB�ֱ�洢��2λ ��3λ ��3λ
pixels = high * width;
img_R = img(:, :, 1);
img_G = img(:, :, 2);
img_B = img(:, :, 3);
clear img;

if rem(pixels, 2) == 1
    pixels = pixels - 1;
end

disp(['�ɴ洢���ַ�����Ϊ��', num2str(pixels / 2), '��']);

% �ַ���ָ��
points = 1;

for each = 1 : 2 : pixels
    % ȡ���ַ��ĸ��ֽ�
    ch = strnum(points);
    highbits = bitand(ch, 65280) / 256;
    
    % ���ֽ�
    lowbits = bitand(ch, 255);
    
    % д���Ӧ��ͨ���У����ֽ�д��ǰ�����ֽ�д�ں�һ������
    hR = bitand(highbits, 192);
    hG = bitand(highbits, 56);
    hB = bitand(highbits, 7);
    
    lR = bitand(lowbits, 192);
    lG = bitand(lowbits, 56);
    lB = bitand(lowbits, 7);
    
    % ����ֽ�
    % Rͨ���ĵ���λ���2λ
    img_R(each) = bitand(img_R(each), 252) + hR;
    % Gͨ���ĵ���λ����3λ
    img_G(each) = bitand(img_G(each), 248) + hG;
    % Gͨ���ĵ���λ���3λ
    img_B(each) = bitand(img_B(each), 248) + hB;
    
    % ����ֽ�
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
imwrite(img, 'C:\Users\���\Desktop\123.bmp')