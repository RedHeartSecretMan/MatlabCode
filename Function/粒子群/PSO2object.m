close all;clear;clc;                

%% 函数定义
tic;                                % 计数开始
%f= @(x,y)x .* sin(x) .* exp(y) .* cos(2 * x) .* exp(2 * y) - 2 * x .* sin(3 * x) .* cos(3 * y);    % 函数表达式
f= @(a,b)(a .* sin(a) .* cos(2 * a) - 2 * a .* sin(3 * a)).*(b .* sin(b) .* cos(2 * b) - 2 * b .* sin(3 * b));    % 函数表达式

%% 种群定义
N = 500;                          % 初始种群个数
d = 2;                            % 空间维数（依据函数表达式自变量数）
ger = 300;                        % 最大迭代次数
plimit = [0,20;0,20];             % 设置位置参数限制(矩阵的形式可以多维)，现在2X2矩阵
vlimit = [-1.5,1.5;-1.5,1.5];     % 设置速度限制
w = 0.8;                          % 惯性权重,个体历史成绩对现在的影响0.5~1之间（不同的权重设置很影响性能，按需要选取）
c1 = 0.5;                         % 自我学习因子
c2 = 0.5;                         % 群体学习因子

for i = 1:d
    x(:,i) = plimit(i, 1) + (plimit(i, 2) - plimit(i, 1)) * rand(N, 1);    % 初始种群的位置
end                               % rand(N,1)产生N行一列范围在1之内的随机数,第一列,第二列：x=0+（20-0）*（1之内的随机数）

v = rand(N, d);                   % 初始种群的速度,500行2列分别在两个维度上
xm = x;                           % 每个个体的历史最佳位置
ym = zeros(1, d);                 % 种群的历史最佳位置，两个维度，设置为0
fxm = zeros(N, 1);                % 每个个体的历史最佳适应度，设置为0
fym = -inf;                       % 种群历史最佳适应度,求最大值先设置成负无穷

figure(1);
[x1, x2]=meshgrid(0:0.2:20);    % 生成网格数据
y0=f(x1,x2);                    % 函数计算
mesh(x1,x2,y0);colorbar;                         
xlabel('第一维度X');
ylabel('第二维度Y');
zlabel('函数值');
hold on
plot3(xm(:,1),xm(:,2),f(xm(:,1),xm(:,2)), 'k.');    %plot3在三维区域画出空间上的点，把格式设置成‘o’用来画每个位置的散点图，r红,g绿,b蓝,c蓝绿,m紫红,y黄,k黑,w白
title('种群初始分布状态图');       

figure(2);
[r,c]=gradient(y0);
contour(x1,x2,y0);
hold on
quiver(x1,x2,r,c);
plot(xm(:,1),xm(:,2), 'k.');
title('种群的等高线梯度分布图');

figure(3);
mesh(x1, x2, y0);
hold on
plot3(xm(:,1),xm(:,2),f(xm(:,1),xm(:,2)), 'ro','MarkerFaceColor',[0 0 0],'MarkerSize',3);

iter = 1;                         % 初始的迭代次数因为用while设置为1
times = 1;                        % 观察数
record = zeros(ger, 1);              

%% 迭代更新
while iter <= ger
    fx = f(x(:,1),x(:,2));               % 代入x中的二维数据，算出个体当前适应度,为500行1列的数据
    for i = 1:N                          % 对每一个个体做判断
        if fxm(i) < fx(i)                % 如果每个个体的历史最佳适应度小于个体当前适应度
            fxm(i) = fx(i);              % 更新个体历史最佳适应度,第一轮就是把小于零的清除
            xm(i,:) = x(i,:);            % 更新个体历史最佳位置
        end 
    end
     
    if fym < max(fxm)                    % 种群历史最佳适应度小于个体里面最佳适应度的最大值
        [fym, nmax] = max(fxm);          % 更新群体历史最佳适应度,取出最大适应度的值和所在行数即位置
        ym = xm(nmax, :);                % 更新群体历史最佳位置
    end
    
    v = v * w + c1 * rand *(xm - x) + c2 * rand *(repmat(ym, N, 1) - x);    % 速度更新公式,repmat函数把ym矩阵扩充成N行2列
    
    
    for i=1:d
        for j=1:N
            if  v(j,i)>vlimit(i,2)       % 如果速度大于边界速度，则把速度拉回边界
                v(j,i)=vlimit(i,2);
            end
            if  v(j,i) < vlimit(i,1)     % 如果速度小于边界速度，则把速度拉回边界
                v(j,i)=vlimit(i,1);
            end
        end
    end
    
    x = x + v;                           % 位置更新
    
    
    for i=1:d
        for j=1:N
            if  x(j,i)>plimit(i,2)
                x(j,i)=plimit(i,2);
            end
            if  x(j,i)<plimit(i,1)
                x(j,i)=plimit(i,1);
            end
        end
    end
    
    record(iter) = fym;                  % 记录器每次迭代群体最优
    
    if times < 30                        % 用于设定希望观察的迭代部分
        figure(3);
        cla;                             % 清除轴线图形
        mesh(x1, x2, y0);
        plot3(xm(:,1),xm(:,2),f(xm(:,1),xm(:,2)), 'ro','MarkerFaceColor',[0 0 0],'MarkerSize',3);
        title('前30代位置的变化状态');
%         pause(0.5);                      % 暂停执行0.5秒，然后继续执行
    end
    iter=iter+1;
    times=times+1;
end

%% 可视化
figure(4);
plot(record);                         % 画出最大值的变化过程
title('迭代过程');


figure(5);
mesh(x1, x2, y0);
hold on;
plot3(x(:,1),x(:,2),f(x(:,1),x(:,2)), 'ro','MarkerFaceColor',[0 0 0],'MarkerSize',3);title('最终位置的状态');

disp(['最大值为：',num2str(fym)]);
disp(['最大值点位置：',num2str(ym)]);
toc                                   % 计时结束