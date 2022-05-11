%%
clear; clc;   
I=imread('rice.png');
subplot(2,3,1); imshow(I);
subplot(2,3,2); J=immultiply(I,1.5);imshow(J);
subplot(2,3,3);
for i=1:size(I,1)
    for j=1:size(I,2)
        if I(i,j) < 125
            K(i,j)=I(i,j)-50;
        else
            K(i,j)=I(i,j)+50;
        end
    end
end
imshow(K);
subplot(2,3,4); imhist(I);ylim([0 1500]);  
subplot(2,3,5); imhist(J);ylim([0 1500]);
subplot(2,3,6); imhist(K);ylim([0 1500]);

%%
clear; clc;
max=0; min=300;
I=imread('rice.png');
subplot(2,3,1); imshow(I); title('ԭͼ','FontSize',10);
subplot(2,3,4); imhist(I); title('ԭͼֱ��ͼ','FontSize',10);
subplot(2,3,2); J=histeq(I); imshow(J); title('��ֵͼ','FontSize',10);
subplot(2,3,5); imhist(J); title('��ֱֵ��ͼ','FontSize',10);
for i=1:size(I,1)% min(I);A=min(I);B=min(A,[],2);max(I);C=max(I),D=max(C,[],2);
    for j=1:size(I,2)
        if max<I(i,j)
            max=I(i,j);
        elseif min>I(i,j)
            min=I(i,j);
        end
    end
end
distance=max-min;
Z=(double(I)-double(min)).*255/double(distance);
Y=uint8(Z);
subplot(2,3,3);imshow(Y); title('�ҵľ�ֵͼ','FontSize',10);
subplot(2,3,6);imhist(Y); title('�ҵľ�ֱֵ��ͼ','FontSize',10);

%%
clear;      
I =imread('rice.png');
Z=I;
level=graythresh(I);    %���������ֵ
a=255 * level;
for i=1:size(I,1)
    for j=1:size(I,2)
        if I(i,j) >a
            Z(i,j)=255;    %��Ϊ���ﲻ�Ƕ�ֵ��ͼ���������Ӧ����255��������1
        else
            Z(i,j)=0;
        end
    end
end
figure(1)
subplot(1,4,1);imshow(I);
subplot(1,4,2):imshow(Z);

subplot(1,4,4);imhist(Z);
subplot(1,4,3);imhist(I);
%%
clear;       
I=imread('rice.png');
BG=imopen(I,strel('disk',15));
I2=imsubtract(I,BG);
level=graythresh(I2);
BW=im2bw(I2,level);
[labeled, numObjects]=bwlabel(BW,8);  %labelded �Ǿ��� numObjects���ж���������.8��8���ӡ�
num=zeros(1,numObjects);
for k=1:numObjects                    %�ܹ���������labeled��Ѱ��1-99��ÿ�����ĸ������ŵ�һ��1*99�ľ����
    for i=1:size(labeled,1)
        for j=1:size(labeled,2)
            if labeled(i,j)==k
                num(1,k)=num(1,k)+1;
            end
        end
    end
end
shu=numObjects
ping=mean(num)         %ƽ��ֵ
zui=max(num)           %��num�������ҵ����ֵ��
                       %������������ʽʱ��max�������Զ���ɱ����ˣ����Բ��ܹ���ʹ�����ú���max()
                       % max=0;
                       % for i=1:numObjects     
                       %     if max<num(1,i)
                       %         max=num(1,i);
                       %     end
                       % end
subplot(1,2,1); hist(num,20);          %��num ��ֱ��ͼ��ʾ����������20��bin
axis square;
[m, n]=size(I);
red_map=zeros(m,n,3);                  %��ΪRGBͼ������ɫ�����ģ����Ը�ÿһ�����ط���һ��[R G B],��ΪֻҪ�ĺ�ɫ��������Ĭ��[0 0 0]
for i=1:size(I,1)
    for j=1:size(I,2)
        if BW(i,j)==1
            red_map(i,j,1)=255;        %���������ĵط�����Ϊ[255 0 0],Ҳ���Ǻ�ɫ
        end
    end
end
subplot(1,2,2); 
imshow(red_map); colorbar;             %ͨ��imshow() �Ѿ��� red_map ��ʾ����