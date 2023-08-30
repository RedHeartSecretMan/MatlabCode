%%
X = [1 3 5 5 5 5 7 9 9 9 10 13 14];

a=mean(X);			% ���ݵ�ƽ��ֵΪ 7.3077
a=median(X);			% ���ݵ���λ��Ϊ 7
c=mode(X);			% ���ݵ�����Ϊ 5
d=prctile(X, 0);		% ���ݵ�0%��λ��Ϊ 0
e=prctile(X, 50);		% ���ݵ�50%��λ��Ϊ 7
f=prctile(X, 100);	% ���ݵ�100%��λ��Ϊ 14
g=prctile(X, 12.6);	% ���ݵ�12.6%��λ��Ϊ 3.2760 

%%
x = 1:14;
freqy = [1 0 1 0 4 0 1 0 3 1 0 0 1 1];
subplot(1,3,1); bar(x,freqy); xlim([0 15]);
subplot(1,3,2); area(x,freqy); xlim([0 15]);
subplot(1,3,3); stem(x,freqy); xlim([0 15]);

%%
marks = [80 81 81 84 88 92 92 94 96 97];
boxplot(marks)
prctile(marks, [25 50 75])	

%%
X = [1 3 5 5 5 5 7 9 9 9 10 13 14];

a=std(X);			% �õ� 3.7944
a=var(X);			% �õ� 14.3974

%%
X = randn([10 3]);		% ����10*3�ľ���
X(X(:,1)<0, 1) = 0; 	% ����һ��������ƫ
X(X(:,3)>0, 3) = 0;		% ���ڶ���������ƫ
boxplot(X, {'Right-skewed', 'Symmetric', 'Left-skewed'});
skewness(X);	% �õ� [0.5162 -0.7539 -1.1234]

%%
load examgrades
x = grades(:,1);
y = grades(:,2);
[h,~] = ttest(x,y);

%%
x = [-1.2 -0.5 0.3 0.9 1.8 2.6 3.0 3.5];
y = [-15.6 -8.5 2.2 4.5 6.6 8.2 8.9 10.0];
for i=1:3
    p = polyfit(x,y,i);	% �ֱ����һ��,����,�������
    xfit = x(1):0.1:x(end); yfit = polyval(p,xfit);
    subplot(1,3,i); plot(x,y,'ro',xfit,yfit); 
    legend('Data points','Fitted curve', 'Location', 'southeast');
end

%%
load carsmall;
y = MPG; x1 = Weight; x2 = Horsepower;		% �������ݼ�
X = [ones(length(x1),1) x1 x2];				% ��������X����
a = regress(y,X);							% �������Իع�

% �����ǻ�ͼ���
x1fit = min(x1):100:max(x1); x2fit = min(x2):10:max(x2);
[X1FIT,X2FIT] = meshgrid(x1fit,x2fit);
YFIT = a(1)+a(2)*X1FIT+a(3)*X2FIT;
scatter3(x1,x2,y,'filled'); hold on;
mesh(X1FIT,X2FIT,YFIT); hold off;
xlabel('Weight'); ylabel('Horsepower'); zlabel('MPG'); view(50,10);

%%
% ��������
x = linspace(0, 2*pi, 40); x_m = x; x_m([11:13, 28:30]) = NaN; 
y_m = sin(x_m);
plot(x_m, y_m, 'ro', 'MarkerFaceColor', 'r'); hold on; 	

% �����ݽ������Բ�ֵ
m_i = ~isnan(x_m);
y_i = interp1(x_m(m_i), y_m(m_i), x);
plot(x,y_i, '-b'); hold on;

% �����ݽ�������������ֵ
m_i = ~isnan(x_m);
y_i = spline(x_m(m_i), y_m(m_i), x);
plot(x,y_i, '-g'); hold off;

legend('Original', 'Linear', 'Spline');

%%
x = -3:3; y = [-1 -1 -1 0 1 1 1]; xq1 = -3:.01:3;
p = pchip(x,y,xq1);
s = spline(x,y,xq1);
plot(x,y,'o',xq1,p,'-',xq1,s,'-.')
legend('Sample Points','pchip','spline','Location','SouthEast')

%%
% ����������
xx = -2:.5:2; yy = -2:.5:3; [x,y] = meshgrid(xx,yy); 
xx_i = -2:.1:2; yy_i = -2:.1:3; [x_i,y_i] = meshgrid(xx_i,yy_i);
z = x.*exp(-x.^2-y.^2);

% ���Բ�ֵ
subplot(1, 2, 1); 
z_i = interp2(xx,yy,z,x_i,y_i);
surf(x_i,y_i,z_i); hold on;
plot3(x,y,z+0.01,'ok','MarkerFaceColor','r'); hold on;

% ���β�ֵ
subplot(1, 2, 2); 
z_ic = interp2(xx,yy,z,x_i,y_i, 'spline');
surf(x_i,y_i,z_ic); hold on;
plot3(x,y,z+0.01,'ok','MarkerFaceColor','r'); hold off;

%%
W=[];
for j=1:51
    Q=[];
    for i=1:51
        w=magic(2);
        Q=[Q;w];
    end
    W=[Q,W];
end
disp(Q);
disp(W);

%%
level = graythresh(headdata); 
a = headdata;
[m,n]=size(a);
for i=1:m
    for j=1:n
        if a(i,j)<level*255
            a(i,j)=a(i,j)*0.65;
        else
            a(i,j)=a(i,j)*0.85;
        end
    end
end
figure;imshow(a)
imwrite(a,'4.png')