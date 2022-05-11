close all;clear;clc;

%% ��ʼ����Ⱥ
tic;
f= @(a,b,c) b .* sin(a) + b .^ 2 + 3 * c .* a; % �������ʽ

N = 500;                        % ��ʼ��Ⱥ����
d = 3;                          % �ռ�ά��
ger = 300;                      % ����������
w = 0.8;
limit = [-2, 2;-2,2; -2,2];                % ����λ�ò�������(�������ʽ���Զ�ά)
vlimit = [-1.5, 1.5;-1.5, 1.5; -1.5, 1.5];               % �����ٶ�����
% ����Ȩ��
c_2 = 0.5;                       % ����ѧϰ����
c_3 = 0.5;                       % Ⱥ��ѧϰ����
for i = 1:d
    x(:,i) = limit(i, 1) + (limit(i, 2) - limit(i, 1)) * rand(N, 1);%��ʼ��Ⱥ��λ��
end
v = rand(N, d);                  % ��ʼ��Ⱥ���ٶ�
xm = x;                          % ÿ���������ʷ���λ��
ym = zeros(1, d);                % ��Ⱥ����ʷ���λ��
fxm = zeros(N, 1);               % ÿ���������ʷ�����Ӧ��
fym = -inf;                      % ��Ⱥ��ʷ�����Ӧ��

%% ����Ⱥ����
iter = 1;
times = 1;
record = zeros(ger, 1);          % ��¼��

while iter <= ger
    fx = f(x(:,1),x(:,2),x(:,3)) ; % ���嵱ǰ��Ӧ��
    for i = 1:N
        if fxm(i) < fx(i)
            fxm(i) = fx(i);     % ���¸�����ʷ�����Ӧ��
            xm(i,:) = x(i,:);   % ���¸�����ʷ���λ��
        end
    end
    if fym < max(fxm)
        [fym, nmax] = max(fxm);   % ����Ⱥ����ʷ�����Ӧ��
        ym = xm(nmax, :);      % ����Ⱥ����ʷ���λ��
    end
    v = v * w + c_2 * rand *(xm - x) + c_3 * rand *(repmat(ym, N, 1) - x);% �ٶȸ���
    % �߽��ٶȴ���
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
    % λ�ø���
    x = x + v;
    % �߽�λ�ô���
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
    record(iter) = fym;%���ֵ��¼
    iter = iter+1;
    times = times+1;
end

figure(1);plot(record);title('��������')
disp(['���ֵ��',num2str(fym)]);
disp(['����ȡֵ��',num2str(ym)]);
toc;