%开始
clear 
clc
close all

Pic=dir('*.bmp');%读取目录下.bmp文件
space_filter=zeros(length(Pic),1);
space_filter=double(space_filter);
M=13.628;
L=length(Pic);

for i=710:1:L
    
    filename=getfield(Pic(i),'name');%返回结构体pic(i) 的指定字段中的值
    A=imread(filename);%读入图片保存在A这个矩阵中（3x3）
    
 
        
 
    A=A(600:700,650:750);%区域选择（列,行）
    
    
    
    [column,row]=size(A);
    
    p=2;%空间周期大小设置
    
    x=1;
    B=zeros(ceil(column/(p+1)),1);

    for j=1:p:column-p-1
     
     B(x)=sum(A(j,:));  
        x=x+1;
    end
    
    Sum = 0;
    

    l=length(B);
        Sum=0;
     
    if(mod(l,2)~=0)
         for k=1:2:l-2
          Sum=Sum+B(k)-B(k+1);
         end
    end

    if(mod(l,2)==0)
        for k=1:2:l-1
           Sum=Sum+B(k)-B(k+1);
        end
   end
     space_filter(i)=Sum;
    end

    y=space_filter;%空间掩膜滤波器

 L = length(y); % L为取样点的个数
 NFFT= 2^nextpow2(L);%为FFT的个数  NFFT=FFT时，分辨率越高，结果越准确

 Fs=1/0.0027;%采样频率
 coef = p*2*M*0.0007   
 window=hamming(20);%海明窗窗长，越小越平滑
 [Pxx2,f]=pwelch(y,window,[],NFFT,Fs);%pxx为功率谱估计值 f为频率，即pxx2为纵坐标，f为横坐标，y为化为频谱图的对象
%Welch方法是一种修正周期图功率谱密度估计方法，它通过选取的窗口对数据进行加窗处理，先分段求功率谱之后再进行平均。其中窗口的长度N表示每次处理的分段数据长度，Noverlap是指相邻两段数据之间的重叠部分长度。N越大得到的功率谱分辨率越高(越准确)，但方差加大(及功率谱曲线不太平滑)；N越小，结果的方差会变小，但功率谱分辨率较低(估计结果不太准确)。


% 1. 将信号分为多段，每段之间可以有overlapping,也可以没有。
% 2. 每一段加窗
% 3. 每一段做谱分析
% 4. 求平均。
% 
% 关于信号到底要分多少段？每一段长度多少？我的理解，这个问题的回答，需要考虑频域分辨率。 当然，每一段时间跨度越大，频域分辨率就越高。如果整个信号不分段，那么频域分辨率最高。当然分段也是为了考虑噪声的影响。分得段越多，噪声越小。 有时候，如果一个信号本身不太长，那么如果有overlapping,显然可以比不overlapping的时候的频域分辨率高。 总结一下，每一段的长度，和overlapping 的长度，需要平衡噪音，频域分辨率。
% 
% 另外注意的是,pwelch里面NFFT,即FFT的个数，是可以变化的。但是最大长度不能超过每一段的点数。当然，很多情况下我们把NFFT等于每一段的点数，这样可以得到最高的频域分辨率。 如果NFFT = 每一段的一半，频域分辨率低一倍。
% 
% 帮助里面
% noverlap must be less than the length of the window you specify,
% the (default) length N of the FFT is the larger of 256 and the next power of 2 greater than the length of the segment.

%创建一个默认属性的窗口
figure('numbertitle','off','name','Black particle');

plot(f,Pxx2);%绘出二维图，f为横坐标，pxx2为纵坐标
hold on;
[peaks_,locs_]=findpeaks(Pxx2);
plot(f(locs_(1)),peaks_(1),'ro');
text(f(locs_(1)),peaks_(1),num2str(f(locs_(1))));
hold on
plot(f(locs_(2)),peaks_(2),'ro');
text(f(locs_(2)),peaks_(2),num2str(f(locs_(2))));
xlabel('frequence','FontSize',15,'Fontweight','bold');
ylabel('power','FontSize',15,'FontWeight','bold');
title('Before binarization');
point2=f(locs_(2))*coef
point1=f(locs_(1))*coef
% 图像处理 优化图像 减小误差

%             for m = 1:length(f)
%                 if find(f(m)>30)% 可以根据背景噪声的强弱来修改%
%                     break;
%                 end
%             end
% 
%             for n = 1:length(f)
%                 if find(f(n)>Fs/2)
%                     break;
%                 end
%             end
% 
%             New = Pxx2(m:n,1);%第一列中从m行到n行的元素
%             
%             [peaks,locs] = findpeaks(New,'minpeakheight',0.8*max(New));%pks 对应峰值，locs 对应峰值位数，设置最小高度
%             
%             locs = locs+m;
% 
%             f_peaks = f(locs);
%             
%             [a,b] = size(f_peaks);
%             
%             if a==1
%                 f_peaks(2,1) = f_peaks(1,1);
%             end
%             
% V_aver = ((f_peaks(1,1)+f_peaks(2,1))/2)*(2*p+1)*0.0007*38.61 %最后一位为放大倍数


