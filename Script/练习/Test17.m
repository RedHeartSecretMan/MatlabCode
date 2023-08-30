%%
x = -2:0.005:2; y = x.^3;
m = diff(y)./diff(x);
m2 = diff(m)./diff(x(1:end-1));
plot(x,y,x(1:end-1),m,x(1:end-2),m2);
xlabel('x', 'FontSize', 18); 
ylabel('y', 'FontSize', 18);
legend('f(x) = x^3','f''(x)','f''''(x)','Location','southeast');
set(gca, 'FontSize', 18);

%%
g = colormap(lines); hold on;
for i=1:4
x = 0:power(10, -i):pi;
y = sin(x); m = diff(y)./diff(x);
plot(x(1:end-1), m, 'Color', g(i,:)); %由于mdiff（~）得到比x少一维，故定义域除去最后一个元素，线条颜色分别区map中4个向量
end
hold off;
set(gca, 'XLim', [0, pi/2]); set(gca, 'YLim', [0, 1.2]);
set(gca, 'FontSize', 18);
set(gca, 'XTick', 0:pi/4:pi/2);
set(gca, 'XTickLabel', {'0', '\pi/4', '\pi/2'});
h = legend('h=0.1','h=0.01','h=0.001','h=0.0001');
set(h,'FontName', 'Times New Roman'); box on;

%%
h = 0.05; x = 0:h:2;
midpoint = (x(1:end-1)+x(2:end))./2;
y = 4*midpoint.^3;
s = sum(h*y);

%%
h = 0.05; x = 0:h:2; y = 4*x.^3;
trapezoid = (y(1:end-1)+y(2:end))/2;
G = h*sum(trapezoid);

%%
y = @(x) 1./(x.^3-2*x-5);
integral(y,0,2)

%%
f = @(x,y) y.*sin(x)+x.*cos(y);
a=integral2(f,pi,2*pi,0,pi);
f = @(x,y,z) y.*sin(x)+z.*cos(y);
b=integral3(f,0,pi,0,1,-1,1);

%%
ln=@(x)log(x);%@(x)表示表达式中x为未知量

%%
syms x
y=cos(x)^2-sin(x)^2;% syms x
solve(y, x)         %solve(cos(x)^2-sin(x)^2, x)
vpa(x)  % 可变精度计算结果值为sym

%%
syms x a b
solve(a*x^2-b)

%%
syms x; y = x^2*exp(x);
z = int(y);%int可求不定积分,不可用数值积分函数ployint&integral...
z = z-subs(z, x, 0);%z(0)=0时z的表达式

%%
f2 = @(x) (1.2*x+0.3+x*sin(x));
fsolve(f2,0)%以0为初值采用最小二乘法计算解根&语法为fsolve('1.2*x+0.3+x*sin(x)',0)

%%
f1=@(x) ([2*x(1)-x(2)-exp(-x(1));-x(1)+2*x(2)-exp(-x(2))]);
fsolve(f1,[-5,5])%此函数只能识别一个变量，可采取标号形式替代多个变量

%%
tic
for r=2.9:0.005:3.85
    x=rand(1);
    for n=1:200
        x=r*x*(1-x);
    end
    for n=201:400
        x=r*x*(1-x);
        plot(r,x,'.');
        hold on
    end
end
toc

%%
x = 10*(rand(1,100)-0.5);y = 10*(rand(100,1)-0.5);
z = 0.5457*exp(-0.75*y.^2-3.75*x.^2-1.5*x);
for i = 1:100
    for j = 1:100
        a = x+y;
        if a<=1
            x(i,j) = 0;y(i,j) = 0;z(i,j) = 0;
        end
    end
end
mesh(x,y,z);

%%
tic
n = 1600;
A = 500;
a = zeros(n);
parfor i = 1:n
    a(i) = max(abs(eig(rand(A))));
end
toc