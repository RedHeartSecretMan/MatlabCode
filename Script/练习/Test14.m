Q%%
x=logspace(-1,1,100);%logspace(a,b,n) ��10����10^a �� 10^b֮������ n ���㡣
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
title('Ƿ����');
set(H1,'LineStyle','--'); set(H2,'LineStyle',':');

%%
y = randn(1,1000);%��������̬�ֲ����������ɵ�1��1000����
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
%��ϰ
t=linspace(0,10,50);ft=sin((pi*t.^2)/4);
hold on;
plot(t,ft,'b');
stem(t,ft,'r');
yticks([-1,-0.5,0,0.5,1]);
hold off;

%%
t =(1:2:15)'*pi/8; x = sin(t); y = cos(t);%�Ծ��������ת��
fill(x,y,'r'); axis square off;
text(0,0,'STOP','Color', 'w', 'FontSize', 80, 'FontWeight','bold', 'HorizontalAlignment', 'center');%fontweight bold����Ӵ�

%%
t=[0 1 2 3]*(pi/2);x=sin(t);y=cos(t);
fill(x,y,'y','linewidth',5);axis off square;%�ȼ���axis square;axis off;
text(0,0,'WAIT','Color', [0,0,0], 'FontSize', 70, 'FontWeight','bold', 'HorizontalAlignment', 'center')%��ɫ:'k',[0,0,0]

%%
G = [46 38 29 24 13]; S = [29 27 17 26 8];
B = [29 23 19 32 7]; h = bar(1:5,[G' S' B']);%function of useful is bar(x,y)��x������Ҫ��y���������ƥ�䣬y����������ƥ�伴��
title('Medal count for top 5 countries in 2012 Olympics');
ylabel('Number of medals'); xlabel('Country');
legend('Gold', 'Silver', 'Bronze')
set(h(1),'facecolor',[1,0.8,0.2]);
set(h(2),'facecolor',[0.8,0.8,0.8]);
set(h(3),'facecolor',[0.8,0.4,0]);
set(gca,'xticklabel',{'USA','CHN','GBR','RUS','KOR'});

%%
[x, y] = meshgrid(-3:0.2:3,-3:0.2:3); %�Ժ���ͼ����Ӹ�����ֵ��������άͼ������ȼ��ڶ�ά����ͼ����ֲ��߶���άͼ����и�
                                      %[X,Y] = meshgrid(x,y) �������� x �� y �а��������귵�ض�ά��������
                                      %X ��һ������ÿһ���� x ��һ��������Y Ҳ��һ������ÿһ���� y ��һ������
                                      %���� X �� Y ��ʾ�������� length(y) ���к� length(x) ����
z = x.^2 + x.*y + y.^2;surf( x, y, z);%����һ����ά����ͼ�Ҹ�������ɫ��surf(X,Y,Z,C) ��ָ���������ɫ 
box on;%���������������� 
set(gca,'FontSize', 16); zlabel('z'); 
xlim([-4 4]); xlabel('x'); 
ylim([-4 4]); ylabel('y');
figure;
imagesc(z); axis square; xlabel('x'); ylabel('y');colorbar;%colormap(hot)��ȡhot��ɫ����

%%
map = zeros(256,3);
map(:,2) = (0:255)/255;
colormap(map);%ʹ��mapɫ�ʿռ䣬�˺���������ֵ������0-1��
x = [1:10; 3:12; 5:14];
imagesc(x);%����x�����ֵ��С˳�����ζ�Ӧɫ������ɫ������������x����ͬ��������Ӧ����ͼ
colorbar;%��ǰɫ����ͼ��Χ�ɾ��������ֵ����Сֵȡ��

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
subplot(1,2,1); mesh(X,Y,Z);%�����
subplot(1,2,2); surf(X,Y,Z);%���

%%
x = -3.5:0.2:3.5; 
y = -3.5:0.2:3.5;
[X,Y] = meshgrid(x,y); 
Z = X.*exp(-X.^2-Y.^2);
subplot(1,2,1); 
contour(X,Y,Z);%�ȸ��ߺ��� 
axis square;
subplot(1,2,2); 
contourf(X,Y,Z); %���ĵȸ��ߺ���
axis square;

%%
x = -3.5:0.2:3.5; y = -3.5:0.2:3.5;
[X,Y] = meshgrid(x,y); Z = X.*exp(-X.^2-Y.^2);
subplot(1,2,1); meshc(X,Y,Z);%��������ͼ���Ƶȸ���ͼ
subplot(1,2,2); surfc(X,Y,Z);%��ά��ɫ����ͼ�µĵȸ���ͼ

%%
sphere(50); shading flat;%ƽ����ɫ
light('Position',[1 3 2]);%����λ��
light('Position',[-3 -1 3]);
material shiny;%���Ϲ���
axis vis3d off;%���������������ת�仯����������ȥ
set(gcf,'Color',[1 1 1]);
view(35,25);%�۲��ӽ�

%%
v = [0 0 0; 1 0 0 ; 1 1 0; 0 1 0; 0.25 0.25 1; 0.75 0.25 1; 0.75 0.75 1; 0.25 0.75 1];
f = [1 2 3 4; 5 6 7 8; 1 2 6 5; 2 3 7 6; 3 4 8 7; 4 1 5 8];
subplot(1,2,1); 
patch('Vertices', v, 'Faces', f,'FaceVertexCData', hsv(6), 'FaceColor', 'flat');%hsv(m)���ذ��� m ����ɫ����ɫͼ
view(3); axis square tight; grid on;
subplot(1,2,2);
patch('Vertices', v, 'Faces', f,'FaceVertexCData', hsv(8), 'FaceColor', 'interp');%patch(~)����һ�������������
view(3); axis square tight; grid on;

%%
load cape
X=conv2(ones(9,9)/81,cumsum(cumsum(randn(100,100)),2));%conv2(~)��ά���
surf(X,'EdgeColor','none','EdgeLighting','Phong','FaceColor','interp');
colormap(map); caxis([-10,300]);
grid off; axis off;