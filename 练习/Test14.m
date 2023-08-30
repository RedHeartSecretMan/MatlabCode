Q%%
x=logspace(-1,1,100);%logspace(a,b,n) 在10的幂10^a 和 10^b之间生成 n 个点。
y=x.^2;
subplot(2,2,1);
plot(x,y);
title('plot');
z=gca;
set(z,'XGrid','on');
subplot(2,2,2);
semilogx(x,y);
v=gcf;
set(v,'color',[1,1,1]);
title('semilogx');
subplot(2,2,3);
b=semilogy(x,y);
title('semilogy');
subplot(2,2,4);
loglog(x,y);
title('loglog');
set(gca,'XGrid','on');

%%
x = 0:0.01:20;
y1 = 200*exp(-0.05*x).*sin(x);
y2 = 0.8*exp(-0.5*x).*sin(10*x);
[AX,H1,H2] = plotyy(x,y1,x,y2);
set(get(AX(1),'Ylabel'),'String','Left Y-axis')
set(get(AX(2),'Ylabel'),'String','Right Y-axis')
title('欠阻尼');
set(H1,'LineStyle','--'); set(H2,'LineStyle',':');

%%
y = randn(1,1000);%返回由正态分布的随机数组成的1×1000矩阵
subplot(2,1,1);
hist(y,10);
title('Bins = 10');
subplot(2,1,2);
hist(y,50);
title('Bins = 50');

%%
x = [1 2 5 4 8]; y = [x;1:5];
subplot(2,3,1); bar(x); title('A bargraph of vector x');
subplot(2,3,2); bar(y); title('A bargraph of vector y');
subplot(2,3,3); bar3(y); title('A 3D bargraph');
subplot(2,3,4); bar(y,'stacked'); title('Stacked');
subplot(2,3,[5,6]); barh(y); title('Horizontal');

%%
a = [10 5 20 30];
subplot(1,3,1); pie(a);
subplot(1,3,2); pie(a, [1,1,1,1]);
subplot(1,3,3); pie3(a, [0,0,0,1]);

%%
x = 1:100; theta = x/10; r = log10(x);
subplot(1,4,1); polar(theta,r);
theta = linspace(0, 2*pi); r = cos(4*theta); 
subplot(1,4,2); polar(theta, r);
theta = linspace(0, 2*pi, 6); r = ones(1,length(theta));
subplot(1,4,3); polar(theta,r);
theta = linspace(0, 2*pi); r = 1-sin(theta);
subplot(1,4,4); polar(theta , r);

%%
x = linspace(0, 4*pi, 40); y = sin(x);
subplot(1,2,1); stairs(y);
subplot(1,2,2); stem(y);

%%
%练习
t=linspace(0,10,50);ft=sin((pi*t.^2)/4);
hold on;
plot(t,ft,'b');
stem(t,ft,'r');
yticks([-1,-0.5,0,0.5,1]);
hold off;

%%
t =(1:2:15)'*pi/8; x = sin(t); y = cos(t);%对矩阵进行了转置
fill(x,y,'r'); axis square off;
text(0,0,'STOP','Color', 'w', 'FontSize', 80, 'FontWeight','bold', 'HorizontalAlignment', 'center');%fontweight bold字体加粗

%%
t=[0 1 2 3]*(pi/2);x=sin(t);y=cos(t);
fill(x,y,'y','linewidth',5);axis off square;%等价于axis square;axis off;
text(0,0,'WAIT','Color', [0,0,0], 'FontSize', 70, 'FontWeight','bold', 'HorizontalAlignment', 'center')%黑色:'k',[0,0,0]

%%
G = [46 38 29 24 13]; S = [29 27 17 26 8];
B = [29 23 19 32 7]; h = bar(1:5,[G' S' B']);%function of useful is bar(x,y)，x长度需要与y矩阵的行数匹配，y是向量个数匹配即可
title('Medal count for top 5 countries in 2012 Olympics');
ylabel('Number of medals'); xlabel('Country');
legend('Gold', 'Silver', 'Bronze')
set(h(1),'facecolor',[1,0.8,0.2]);
set(h(2),'facecolor',[0.8,0.8,0.8]);
set(h(3),'facecolor',[0.8,0.4,0]);
set(gca,'xticklabel',{'USA','CHN','GBR','RUS','KOR'});

%%
[x, y] = meshgrid(-3:0.2:3,-3:0.2:3); %对函数图像添加给定数值的网格，三维图像网格等价于二维俯视图网格分布线对三维图像的切割
                                      %[X,Y] = meshgrid(x,y) 基于向量 x 和 y 中包含的坐标返回二维网格坐标
                                      %X 是一个矩阵，每一行是 x 的一个副本；Y 也是一个矩阵，每一列是 y 的一个副本
                                      %坐标 X 和 Y 表示的网格有 length(y) 个行和 length(x) 个列
z = x.^2 + x.*y + y.^2;surf( x, y, z);%创建一个三维曲面图且给曲面上色，surf(X,Y,Z,C) 还指定曲面的颜色 
box on;%开坐标区域轮廓线 
set(gca,'FontSize', 16); zlabel('z'); 
xlim([-4 4]); xlabel('x'); 
ylim([-4 4]); ylabel('y');
figure;
imagesc(z); axis square; xlabel('x'); ylabel('y');colorbar;%colormap(hot)是取hot颜色矩阵

%%
map = zeros(256,3);
map(:,2) = (0:255)/255;
colormap(map);%使用map色彩空间，此函数矩阵数值必须在0-1内
x = [1:10; 3:12; 5:14];
imagesc(x);%根据x数组的值大小顺序依次对应色彩条颜色并画出于数组x行列同数量的相应方格图
colorbar;%当前色彩条图像范围由矩阵中最大值和最小值取定

%%
x=0:0.1:3*pi; z1=sin(x); z2=sin(2.*x); z3=sin(3.*x);
y1=zeros(size(x)); y3=ones(size(x)); y2=y3./2;
plot3(x,y1,z1,'r',x,y2,z2,'b',x,y3,z3,'g'); grid on; 
xlabel('x-axis'); ylabel('y-axis'); zlabel('z-axis');

%%
t=(0:0.01:2*pi);y=2*cos(t)-cos(2*t);x=2*sin(t)-sin(2*t);
fill(x,y,'r');axis off;

%%
turns = 40*pi;
t = linspace(0,turns,4000);
x = cos(t).*(turns-t)./turns;
y = sin(t).*(turns-t)./turns;
z = t./turns;
plot3(x,y,z); grid on;

%%
x = -3.5:0.2:3.5; y = -3.5:0.2:3.5;
[X,Y] = meshgrid(x,y);
Z = X.*exp(-X.^2-Y.^2);
subplot(1,2,1); mesh(X,Y,Z);%不填充
subplot(1,2,2); surf(X,Y,Z);%填充

%%
x = -3.5:0.2:3.5; 
y = -3.5:0.2:3.5;
[X,Y] = meshgrid(x,y); 
Z = X.*exp(-X.^2-Y.^2);
subplot(1,2,1); 
contour(X,Y,Z);%等高线函数 
axis square;
subplot(1,2,2); 
contourf(X,Y,Z); %填充的等高线函数
axis square;

%%
x = -3.5:0.2:3.5; y = -3.5:0.2:3.5;
[X,Y] = meshgrid(x,y); Z = X.*exp(-X.^2-Y.^2);
subplot(1,2,1); meshc(X,Y,Z);%根据网格图绘制等高线图
subplot(1,2,2); surfc(X,Y,Z);%三维着色曲面图下的等高线图

%%
sphere(50); shading flat;%平滑着色
light('Position',[1 3 2]);%光线位置
light('Position',[-3 -1 3]);
material shiny;%材料光泽
axis vis3d off;%坐标轴比例不随旋转变化，坐标轴隐去
set(gcf,'Color',[1 1 1]);
view(35,25);%观察视角

%%
v = [0 0 0; 1 0 0 ; 1 1 0; 0 1 0; 0.25 0.25 1; 0.75 0.25 1; 0.75 0.75 1; 0.25 0.75 1];
f = [1 2 3 4; 5 6 7 8; 1 2 6 5; 2 3 7 6; 3 4 8 7; 4 1 5 8];
subplot(1,2,1); 
patch('Vertices', v, 'Faces', f,'FaceVertexCData', hsv(6), 'FaceColor', 'flat');%hsv(m)返回包含 m 种颜色的颜色图
view(3); axis square tight; grid on;
subplot(1,2,2);
patch('Vertices', v, 'Faces', f,'FaceVertexCData', hsv(8), 'FaceColor', 'interp');%patch(~)创建一个或多个填充多边形
view(3); axis square tight; grid on;

%%
load cape
X=conv2(ones(9,9)/81,cumsum(cumsum(randn(100,100)),2));%conv2(~)二维卷积
surf(X,'EdgeColor','none','EdgeLighting','Phong','FaceColor','interp');
colormap(map); caxis([-10,300]);
grid off; axis off;