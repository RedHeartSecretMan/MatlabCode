%%
bw = imbinarize(x539);     % 或bw = edge(imread(path));
subplot(2 ,4 ,1); imshow(bw);
BG1 = imopen(bw, strel('disk' ,10));
subplot(2 ,4 ,2); imshow(BG1);

BW = bw;
[h, w]=size(BW);
r = floor(h/10);     % 分成10块行
c = floor(w/10);     % 分成10块列
x1 = 1;     % 对应行初始化
x2 = r;     
s = r*c;     % 块面积

for i = 1 : 10
    y1 = 1;     % 对应列初始化
    y2 = c;     
    for j = 1 : 10
        if (y1<=2*c || y2>=9*c) || (x1<=2*r || x2>=9*r)     % 对四周区域进行处理 
            area = find(BW(x1 : x2 ,y1 : y2) == 0);     % 找到一块中的像素为0的坐标结果存在矩阵中
            [o ,p] = size(area);
            pr = o*p/s*100;     % 黑色像素所占百分比
            if pr <= 100
                BW(x1 : x2 ,y1 : y2)=0;     % 该块变成全黑
                imshow(BW)
            end
        end    
        y1=y1+c;
        y2=y2+c;
    end
    x1=x1+r;
    x2=x2+r;
end

subplot(2 ,4 ,3);imshow(BW)

register = bwareaopen(BW,5);     % 删除少于 5 个像素的所有连通量
subplot(2 ,4 ,4);imshow(register)

jie = edge(register);
subplot(2 ,4 ,5);imshow(register)

BG2 = imopen(register, strel('disk' ,8));
subplot(2 ,4 ,6); imshow(BG2);

%%
[L1 ,a1 ,a2 ,L2 ,b1 ,b2 ,L3] = ClearOtherPoint(x539);
disp([L1 ,a1 ,a2 ,L2 ,b1 ,b2 ,L3]);

Image = imcrop(x539,[L1 ,L2 ,L3 ,L3]);
subplot(2 ,4 ,7); imshow(Image);

Image1 = imcrop(x539,[a1 ,b1 ,a2-a1, b2-b1]);
level = graythresh(Image1);     % 面部最佳灰度阈值

Fan1 = 0.65;     %暗部增强系数
Fan2 = 0.88;     %亮部减弱系数
max1 = Fan1*double(max(max(aij)));
min1 = Fan2*double(min(min(aij)));
J = 255/(max1-min1);     %防止溢出映射系数

aij = x539;
[m ,n] = size(x539);

for i = 1 : n
    if ((i >= a1) && (i <= a2))
        for j = 1 : m
            if ((j >= b1) && (j <= b2))
                if aij(i ,j) < level*255     % 目标区域
                    aij(i ,j) = aij(i ,j)*Fan1*J;     % 暗部
                else
                    aij(i ,j) = uint8(uint16(aij(i ,j)*Fan2)*J);     % 亮部
                end
            else
                if aij(i ,j) < level*255     % 2 ,7区域
                    aij(i ,j) = aij(i ,j)*Fan1*J;
                else
                    aij(i ,j) = uint8(uint16(aij(i ,j)*Fan2)*J);
                end
            end
        end
    else
        for j = 1 : m
            if aij(i ,j) < level*255     % 1 ,4 ,6 ,3 ,5 ,8 区域
                aij(i ,j) = aij(i ,j)*Fan1*J;
            else
                aij(i ,j) = uint8(uint16(aij(i ,j)*Fan2)*J);
            end
        end
    end
end

Image2 = imcrop(aij,[L1 ,L2 ,L3 ,L3]);
subplot(2 ,4 ,8);imshow(Image2);
