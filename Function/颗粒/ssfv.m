%��ʼ
clear 
clc
close all

Pic=dir('*.bmp');%��ȡĿ¼��.bmp�ļ�
space_filter=zeros(length(Pic),1);
space_filter=double(space_filter);
M=13.628;
L=length(Pic);

for i=710:1:L
    
    filename=getfield(Pic(i),'name');%���ؽṹ��pic(i) ��ָ���ֶ��е�ֵ
    A=imread(filename);%����ͼƬ������A��������У�3x3��
    
 
        
 
    A=A(600:700,650:750);%����ѡ����,�У�
    
    
    
    [column,row]=size(A);
    
    p=2;%�ռ����ڴ�С����
    
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

    y=space_filter;%�ռ���Ĥ�˲���

 L = length(y); % LΪȡ����ĸ���
 NFFT= 2^nextpow2(L);%ΪFFT�ĸ���  NFFT=FFTʱ���ֱ���Խ�ߣ����Խ׼ȷ

 Fs=1/0.0027;%����Ƶ��
 coef = p*2*M*0.0007   
 window=hamming(20);%������������ԽСԽƽ��
 [Pxx2,f]=pwelch(y,window,[],NFFT,Fs);%pxxΪ�����׹���ֵ fΪƵ�ʣ���pxx2Ϊ�����꣬fΪ�����꣬yΪ��ΪƵ��ͼ�Ķ���
%Welch������һ����������ͼ�������ܶȹ��Ʒ�������ͨ��ѡȡ�Ĵ��ڶ����ݽ��мӴ������ȷֶ�������֮���ٽ���ƽ�������д��ڵĳ���N��ʾÿ�δ���ķֶ����ݳ��ȣ�Noverlap��ָ������������֮����ص����ֳ��ȡ�NԽ��õ��Ĺ����׷ֱ���Խ��(Խ׼ȷ)��������Ӵ�(�����������߲�̫ƽ��)��NԽС������ķ�����С���������׷ֱ��ʽϵ�(���ƽ����̫׼ȷ)��


% 1. ���źŷ�Ϊ��Σ�ÿ��֮�������overlapping,Ҳ����û�С�
% 2. ÿһ�μӴ�
% 3. ÿһ�����׷���
% 4. ��ƽ����
% 
% �����źŵ���Ҫ�ֶ��ٶΣ�ÿһ�γ��ȶ��٣��ҵ���⣬�������Ļش���Ҫ����Ƶ��ֱ��ʡ� ��Ȼ��ÿһ��ʱ����Խ��Ƶ��ֱ��ʾ�Խ�ߡ���������źŲ��ֶΣ���ôƵ��ֱ�����ߡ���Ȼ�ֶ�Ҳ��Ϊ�˿���������Ӱ�졣�ֵö�Խ�࣬����ԽС�� ��ʱ�����һ���źű���̫������ô�����overlapping,��Ȼ���ԱȲ�overlapping��ʱ���Ƶ��ֱ��ʸߡ� �ܽ�һ�£�ÿһ�εĳ��ȣ���overlapping �ĳ��ȣ���Ҫƽ��������Ƶ��ֱ��ʡ�
% 
% ����ע�����,pwelch����NFFT,��FFT�ĸ������ǿ��Ա仯�ġ�������󳤶Ȳ��ܳ���ÿһ�εĵ�������Ȼ���ܶ���������ǰ�NFFT����ÿһ�εĵ������������Եõ���ߵ�Ƶ��ֱ��ʡ� ���NFFT = ÿһ�ε�һ�룬Ƶ��ֱ��ʵ�һ����
% 
% ��������
% noverlap must be less than the length of the window you specify,
% the (default) length N of the FFT is the larger of 256 and the next power of 2 greater than the length of the segment.

%����һ��Ĭ�����ԵĴ���
figure('numbertitle','off','name','Black particle');

plot(f,Pxx2);%�����άͼ��fΪ�����꣬pxx2Ϊ������
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
% ͼ���� �Ż�ͼ�� ��С���

%             for m = 1:length(f)
%                 if find(f(m)>30)% ���Ը��ݱ���������ǿ�����޸�%
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
%             New = Pxx2(m:n,1);%��һ���д�m�е�n�е�Ԫ��
%             
%             [peaks,locs] = findpeaks(New,'minpeakheight',0.8*max(New));%pks ��Ӧ��ֵ��locs ��Ӧ��ֵλ����������С�߶�
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
% V_aver = ((f_peaks(1,1)+f_peaks(2,1))/2)*(2*p+1)*0.0007*38.61 %���һλΪ�Ŵ���


