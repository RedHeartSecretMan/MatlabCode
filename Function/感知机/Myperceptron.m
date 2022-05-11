function Myperceptron
% ���Ը�֪��
clc;
% ���ɲ������� 100�����ݣ�0-10֮��ֱ�λ��y = x����
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
% ����һ����֪��������Ĭ�ϲ���
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
% ��֪��ѵ������
% x���룬p*n�ľ���p�Ǳ���������n������������y��1*n������
% echosѵ������
% Perceptronһ��������ʼ���ĸ�֪��
% show��ʾ����ļ��
% ����ѵ���õĸ�֪��
nx = size(x, 2);
ny = size(y, 2);
if isempty(x)
    error('�������ݲ���Ϊ�գ�');
elseif isempty(y)
    error('������ݲ���Ϊ�գ�');
elseif nx ~= ny
    error('�����������������ά�Ȳ�ƥ�䣡');
end
% ѵ����֪��
strate = Perceptron.studyrate;  % ѧϰ��
w      = [Perceptron.powerb, Perceptron.powerw]'; % Ȩֵ
trainx = [ones(1, nx); x];   % ѵ���õ�����
pgoal  = +inf;  % ��ǰ���
nshow = 1;
for i = 1 : echos
    % �����ʵ������Ĳ�ֵ
    for k = 1 : ny
        % ���㵱ǰ��֪�����
        py = w' * trainx;
        if strcmp(Perceptron.outfcn, 'bin')
            % ��ȡ��ֵ���
            py(py >= 0) = 1;
            py(py < 0)  = -1;
        end
        dy = y - py;
        % ����Ȩֵ
        w = w + strate*dy(k)*trainx(:, k);
    end
    
    % ���㵱ǰ���
    pgoal = sum(abs(dy));
    if pgoal <= Perceptron.goal
        % �ﵽѵ��Ŀ��
        disp('ѵ�����');
        disp(['��ǰѵ������Ϊ��', num2str(i), '��']);
        disp(['��ǰ���Ϊ', num2str(pgoal)]);
        Perceptron.powerw = w(2:end);
        Perceptron.powerb =w(1);
        TrainedPerceptron = Perceptron;
        return;
    end
    
    % ����ѵ��
    nshow = nshow + 1;
    if nshow == show
        % ��ʾ��ǰѵ�����
        disp(['��ǰѵ������Ϊ��', num2str(i), '��']);
        disp(['��ǰ���Ϊ', num2str(pgoal)]);
        nshow = 1;
    end
end
Perceptron.powerw = w(2:end);
Perceptron.powerb =w(1);
TrainedPerceptron = Perceptron;
end

function Perceptron = CreateMyPerceptron(n)
% ����һ�����������֪���Ľṹ�壬�ṹ�������֪����Ȩֵ��ƫ��Ȩֵ�Լ��������
% nΪ��������ĸ���

% res.powerw    Ȩֵ�����
% res.powerb    ƫ��Ȩֵ�����
% res.outfcn    ���������Ĭ��Ϊ��ֵ����,binΪ��ֵ����
% res.studyrate ѧϰ�ʣ�Ĭ��Ϊ0.1
% res.goal      ѵ�����ȣ�Ĭ��1e-3
pres = struct('powerw', rand(1, n), 'powerb', rand, 'outfcn', 'bin',....
              'studyrate', 0.1, 'goal', 1e-3);
Perceptron  = pres;
end