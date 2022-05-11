function PSO(fitness,N,w,c1,c2,M,D,cycle)
%%% 给定初始条件 %%%
% 如有需要可在调用前修改初始化数据
% fitness 适应度，是一个函数表达式的最优解
% N 初始化群体个体数目
% w 惯性权重（0.5~1）
% c1 个体学习因子（通常取2左右）
% c2 群体学习因子（通常取2左右）
% M 最大迭代次数
% D 搜索空间维数
% cycle 独立过程层数

%%% 初始化粒子位置速度，初始化各个粒子的适应度，P个体最优适应度和Pbest群体最优适应度 %%%
tic;
format long
xlimit=[0,0;20,20];    % 规定粒子运动位置范围，第一行为最小值，第二行为最大值，列代表各个维度
vlimit=[-1.5,-1.5;1.5,1.5];    % 规定粒子运动速度范围，第一行为最小值，第二行为最大值，列代表各个维度
mybin1=zeros(cycle,1);
mybin2=zeros(cycle,D);
mybin3=zeros(M,cycle);
for cyc=1:cycle
    x=zeros(N,D);
    v=zeros(N,D);
    P=zeros(N,1);
    R=zeros(N,D);
    record=zeros(M,1);
    for j=1:D
        x(:,j)=xlimit(1,j)+(xlimit(2,j)-xlimit(1,j))*rand(N, 1);    % 初始化位置
        v(:,j)=vlimit(1,j)+(vlimit(2,j)-vlimit(1,j))*rand(N, 1);    % 初始化速度
    end
    for i=1:N
        P(i)=fitness(x(i,1),x(i,2));    % 预设个体适应度（输入量根据自变量调整）
        R(i,:)=x(i,:);    % 寄存历史位置信息
    end
    Pg=x(N,:);    % 令一全局最优位置数据
    for i=1:(N-1)
        if fitness(x(i,1),x(i,2))>fitness(Pg(1,1),Pg(1,2))
            Pg=x(i,:);
        end
    end
    Pbest=fitness(Pg(1,1),Pg(1,2));    % 预设群体最优（也可根据实际需要预设为inf等等）
%%% 进入主要循环，按照公式依次迭代位置与速度，直到适应度满足需要 %%%
    for t=1:M    % 循环迭代次数
        for i=1:N
            v(i,:)=w*v(i,:)+c1*rand*(R(i,:)-x(i,:))+c2*rand*(Pg-x(i,:));     % 更新粒子速度
            for j=1:D
                if v(i,j)<vlimit(1,j)    % 如果迭代速度小于边界速度，则把速度限定在边界
                    v(i,j)=vlimit(1,j);
                end
                if v(i,j)>vlimit(2,j)    % 如果迭代速度大于边界速度，则把速度限定在边界
                    v(i,j)=vlimit(2,j);
                end
            end
            x(i,:)=x(i,:)+v(i,:);     % 更新粒子位置
            for j=1:D
                if x(i,j)<xlimit(1,j)    % 如果迭代位置小于边界速度，则把位置限定在边界
                    x(i,j)=xlimit(1,j);
                end
                if x(i,j)>xlimit(2,j)    % 如果迭代位置大于边界位置，则把位置限定在边界
                    x(i,j)=xlimit(2,j);
                end
            end
            if fitness(x(i,1),x(i,2))>P(i)
                P(i)=fitness(x(i,1),x(i,2));
                R(i,:)=x(i,:);    % 更新历史位置信息
            end
            if P(i)>Pbest    % 更新群体全局最优位置
                Pg=R(i,:);
            end
        end
        Pbest=fitness(Pg(1,1),Pg(1,2));
        record(t)=Pbest;    % 记录每次的群体全局最优
    end
    mybin1(cyc)=Pbest;
    mybin2(cyc,:)=Pg;
    mybin3(:,cyc)=record;
end
%%% 显示计算结果和图表 %%%
[Pbest,xu]=max(mybin1);
Pg=mybin2(xu,:);
record=mybin3(:,xu);
figure(1);
plot(record);
title('迭代过程');
disp('最大值点为:');disp(Pg);
disp('最大值为：');disp(Pbest);
toc;
end

