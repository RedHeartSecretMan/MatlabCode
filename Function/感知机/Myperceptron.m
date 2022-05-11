function Myperceptron
% 测试感知机
clc;
% 生成测试数据 100组数据，0-10之间分别位于y = x两侧
nx = 100;
x = rand(2, nx)*10;
y = zeros(1, nx);
for i = 1 : nx
    if x(1, i) > x(2, i)
        y(i) = -1;
    else
        y(i) = 1;
    end
end
n = size(x, 1);
hold on;
grid on;
xlim([0 10]);
ylim([0 10]);
x1 = [];
x2 = [];
for i = 1 : nx
    if y(i) == 1
        x1 = [x1, x(:, i)];
    else
        x2 = [x2, x(:, i)];
    end
end
plot(x1(1, :), x1(2, :), 'rp', 'MarkerSize', 10);
plot(x2(1, :), x2(2, :), 'kx', 'MarkerSize', 10);
legend('y = 1', 'y = -1')
% 创建一个感知机，采用默认参数
Perceptron = CreateMyPerceptron(n);
Perceptron.studyrate = 0.01;
echos = 10000;
show = 100;
TrainedPerceptron = MyPerceptronTrain(Perceptron, x, y, echos, show);
w = TrainedPerceptron.powerw
b = TrainedPerceptron.powerb
f = @(x)(-w(1)*x-b)/w(2);
x = linspace(0, 10, 10);
plot(x, f(x), 'b');
end

function TrainedPerceptron = MyPerceptronTrain(Perceptron, x, y, echos, show)
% 感知机训练函数
% x输入，p*n的矩阵，p是变量个数，n是数据组数，y是1*n的向量
% echos训练次数
% Perceptron一个经过初始化的感知机
% show显示结果的间隔
% 返回训练好的感知机
nx = size(x, 2);
ny = size(y, 2);
if isempty(x)
    error('输入数据不能为空！');
elseif isempty(y)
    error('输出数据不能为空！');
elseif nx ~= ny
    error('输入数据与输出数据维度不匹配！');
end
% 训练感知机
strate = Perceptron.studyrate;  % 学习率
w      = [Perceptron.powerb, Perceptron.powerw]'; % 权值
trainx = [ones(1, nx); x];   % 训练用的输入
pgoal  = +inf;  % 当前误差
nshow = 1;
for i = 1 : echos
    % 计算和实际输出的差值
    for k = 1 : ny
        % 计算当前感知机输出
        py = w' * trainx;
        if strcmp(Perceptron.outfcn, 'bin')
            % 采取阈值输出
            py(py >= 0) = 1;
            py(py < 0)  = -1;
        end
        dy = y - py;
        % 更新权值
        w = w + strate*dy(k)*trainx(:, k);
    end
    
    % 计算当前误差
    pgoal = sum(abs(dy));
    if pgoal <= Perceptron.goal
        % 达到训练目标
        disp('训练完成');
        disp(['当前训练次数为第', num2str(i), '次']);
        disp(['当前误差为', num2str(pgoal)]);
        Perceptron.powerw = w(2:end);
        Perceptron.powerb =w(1);
        TrainedPerceptron = Perceptron;
        return;
    end
    
    % 继续训练
    nshow = nshow + 1;
    if nshow == show
        % 显示当前训练结果
        disp(['当前训练次数为第', num2str(i), '次']);
        disp(['当前误差为', num2str(pgoal)]);
        nshow = 1;
    end
end
Perceptron.powerw = w(2:end);
Perceptron.powerb =w(1);
TrainedPerceptron = Perceptron;
end

function Perceptron = CreateMyPerceptron(n)
% 返回一个描述单层感知机的结构体，结构体包括感知机的权值、偏置权值以及输出函数
% n为输入变量的个数

% res.powerw    权值，随机
% res.powerb    偏置权值，随机
% res.outfcn    输出函数，默认为二值函数,bin为二值函数
% res.studyrate 学习率，默认为0.1
% res.goal      训练精度，默认1e-3
pres = struct('powerw', rand(1, n), 'powerb', rand, 'outfcn', 'bin',....
              'studyrate', 0.1, 'goal', 1e-3);
Perceptron  = pres;
end