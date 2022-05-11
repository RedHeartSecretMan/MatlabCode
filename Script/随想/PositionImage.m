function [L1 ,a1 ,a2 ,L2 ,b1 ,b2 ,L3] = PositionImage(X)

% 提取人脸边界

bw = imbinarize(X);
BW = bw;
% figure;imshow(BW);

k = 10;
[h, w]=size(BW);
r = floor(h/k);     % 分成10块行大小
c = floor(w/k);     % 分成10块列大小
x1 = 1;     % 对应行初始化
x2 = r;     % 对应行上限
s = r*c;     % 块大小
value = 0;     % 边界像素值   

for i = 1 : k
    y1 = 1;     % 对应列初始化
    y2 = c;     % 对应列上限
    for j = 1 : k
        if (y1 <= 2*c || y2 > 8*c) || (x1 <= 2*r || x2 > 8*r)     % 对四周区域进行处理 
            area = find(BW(x1 : x2 ,y1 : y2) == 0);     % 找到当前块中的黑色像素坐标值
            [o ,p] = size(area);
            pr = o*p/s*100;     % 黑色像素占比
            if pr <= 100
                BW(x1 : x2 ,y1 : y2)=0;     % 该块变成全黑
%                 figure;imshow(BW);
            end
        end    
        y1=y1+c;
        y2=y2+c;
    end
    x1=x1+r;
    x2=x2+r;
end

% figure;imshow(BW);
register = BW;
% register = bwareaopen(BW,5);     % 删除少于 5 个像素的连通区域
% figure;imshow(register);
% 寻找边界范围

v1 = 0;
v2 = 0;
v3 = 0;
v4 = 0;
a1 = 1;
a2 = 250;
b1 = 1;
b2 = 250;

[m ,n] = size(register);
for i = 1 : 1 : m
    for j = 1 : 1 : n
      if register(i ,j) == value
          b1 = i;
          v1 = 1;
          break
      end
    end
    if v1 == 1
        break
    end
end
for i =  1 : 1 : n 
    for j = 1 : 1 : m 
      if register(j ,i) == value
          a1 = i;
          v2 = 1;
          break
      end
    end
    if v2 == 1
         break
    end
end
for i = m : -1 : 1
    for j = n : -1 : 1
      if register(i ,j) == value
          b2 = i;
          v3 = 1;
          break
      end
    end
    if v3 == 1
       break
    end
end
for i = n : -1 : 1
    for j = m : -1 : 1
      if register(j ,i) == value
          a2 = i;
          v4 = 1;
          break
      end
    end
    if v4 == 1
         break
    end
end

% 返回值根据需求写表达式
L3 = max([a2-a1 ,b2-b1])+16;
L1 = a1-floor((L3-(a2-a1))/2);
L2 = b1-floor((L3-(b2-b1))/2);

end