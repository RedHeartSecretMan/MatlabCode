close all;clear;clc;

%% 初始化种群
tic;
f= @(a,b,c) b .* sin(a) + b .^ 2 + 3 * c .* a; % 函数表达式

N = 500;                        % 初始种群个数
d = 3;                          % 空间维数
ger = 300;                      % 最大迭代次数
w = 0.8;
limit = [-2, 2;-2,2; -2,2];                % 设置位置参数限制(矩阵的形式可以多维)
vlimit = [-1.5, 1.5;-1.5, 1.5; -1.5, 1.5];               % 设置速度限制
% 惯性权重
c_2 = 0.5;                       % 自我学习因子
c_3 = 0.5;                       % 群体学习因子
for i = 1:d
    x(:,i) = limit(i, 1) + (limit(i, 2) - limit(i, 1)) * rand(N, 1);%初始种群的位置
end
v = rand(N, d);                  % 初始种群的速度
xm = x;                          % 每个个体的历史最佳位置
ym = zeros(1, d);                % 种群的历史最佳位置
fxm = zeros(N, 1);               % 每个个体的历史最佳适应度
fym = -inf;                      % 种群历史最佳适应度

%% 粒子群工作
iter = 1;
times = 1;
record = zeros(ger, 1);          % 记录器

while iter <= ger
    fx = f(x(:,1),x(:,2),x(:,3)) ; % 个体当前适应度
    for i = 1:N
        if fxm(i) < fx(i)
            fxm(i) = fx(i);     % 更新个体历史最佳适应度
            xm(i,:) = x(i,:);   % 更新个体历史最佳位置
        end
    end
    if fym < max(fxm)
        [fym, nmax] = max(fxm);   % 更新群体历史最佳适应度
        ym = xm(nmax, :);      % 更新群体历史最佳位置
    end
    v = v * w + c_2 * rand *(xm - x) + c_3 * rand *(repmat(ym, N, 1) - x);% 速度更新
    % 边界速度处理
    for i=1:d
        for j=1:N
            if  v(j,i)>vlimit(i,2)
                v(j,i)=vlimit(i,2);
            end
            if  v(j,i) < vlimit(i,1)
                v(j,i)=vlimit(i,1);
            end
        end
    end
    % 位置更新
    x = x + v;
    % 边界位置处理
    for i=1:d
        for j=1:N
            if  x(j,i)>limit(i,2)
                x(j,i)=limit(i,2);
            end
            if  x(j,i) < limit(i,1)
                x(j,i)=limit(i,1);
            end
        end
    end
    record(iter) = fym;%最大值记录
    iter = iter+1;
    times = times+1;
end

figure(1);plot(record);title('收敛过程')
disp(['最大值：',num2str(fym)]);
disp(['变量取值：',num2str(ym)]);
toc;